class Cpu < ActiveRecord::Base
  belongs_to :cpu_name
  belongs_to :cpu_family
  belongs_to :cpu_bit
  belongs_to :manufacturer
  has_and_belongs_to_many :hardware, :join_table => :cpus_hardware
  
  validates_presence_of :cpu_name, :cpu_bit, :manufacturer
  validates_uniqueness_of :cpu_name_id, :scope => [:manufacturer_id, :clock]
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, cpu_name_id'
  
  SEARCH_FIELDS = {
    :name => 'cpu_name_id',
    :family => 'cpu_family_id',
    :bit => 'cpu_bit_id',
    :manufacturer => 'manufacturers.name',
    :clock => 'clock'
  }
  
  def self.filter(params)
    conditions = [self.concat_query, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'manufacturers.name, cpu_name_id'} #{params[:desc]}",
      :include => :manufacturer
    )
  end
  
  def self.concat_query
    string  = SEARCH_FIELDS.values.inject([]) do |fields, field|
      fields << "IFNULL(#{field}, '')"
    end
    "concat(#{string.join(', ')}) like ?"
  end
  
  def name(format=:short)
    case format
    when :short
      "#{manufacturer.name} #{cpu_name_id}"
    when :long
      clock = "@#{self.clock}" unless self.clock.blank?
      "#{name(:short)} #{clock}, #{cpu_bit_id} #{cpu_family_id} family"
    when :info
      "#{name(:short)}, #{cpu_bit_id} #{cpu_family_id} family"
    end
  end

  def full_name
    name(:long)
  end
end
