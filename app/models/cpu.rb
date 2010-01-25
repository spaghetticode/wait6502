class Cpu < ActiveRecord::Base
  belongs_to :cpu_name
  belongs_to :cpu_family
  belongs_to :cpu_bit
  belongs_to :manufacturer
  has_and_belongs_to_many :hardware, :join_table => :cpus_hardware
  belongs_to :parent_cpu, :class_name => 'Cpu', :foreign_key => 'parent_cpu_id'
  has_many :children_cpus, :class_name => 'Cpu', :foreign_key => 'parent_cpu_id'
  
  validates_presence_of :cpu_name, :cpu_bit, :manufacturer
  validates_uniqueness_of :cpu_name_id, :scope => [:manufacturer_id, :clock]
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, cpu_name_id'
  named_scope :main, :conditions => {:clock => '', :parent_cpu_id => nil} # parent and parents are already used 
  
  acts_as_permalink :full_name
  
  def all_hardware
    children_hardware = children_cpus.map{|c| c.hardware}.flatten.uniq
    hardware + children_hardware
  end
  
  SEARCH_FIELDS = {
    :name => 'cpu_name_id',
    :family => 'cpu_family_id',
    :bit => 'cpu_bit_id',
    :manufacturer => 'manufacturers.name',
    :clock => 'clock'
  }
  
  def self.filter(params)
    conditions = [ilike_string, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'manufacturers.name, cpu_name_id'} #{params[:desc]}",
      :include => :manufacturer
    )
  end
  
  def self.ilike_string
    string  = SEARCH_FIELDS.values.inject([]) do |fields, field|
      fields << "COALESCE(#{field}, '')"
    end
    "#{string.join(' || ')} ILIKE ?"
  end
  
  def name(format=:short)
    case format
    when :short
      "#{manufacturer.name} #{cpu_name_id}"
    when :long
      clock = "@#{self.clock}" unless self.clock.blank?
      "#{name} #{clock}, #{cpu_bit_id} #{cpu_family_id} family"
    when :clock
      self.clock.blank? ? "#{name}" : "#{name} @#{self.clock}"
    when :info
      "#{name}, #{cpu_bit_id} "
    else
      name(:short)
    end
  end

  def full_name
    name(:long)
  end
  
  def clock_name
    name(:clock)
  end
end
