class CoCpu < ActiveRecord::Base
  belongs_to :co_cpu_name
  belongs_to :co_cpu_type
  belongs_to :cpu_family
  belongs_to :manufacturer
  has_and_belongs_to_many :hardware, :join_table => :co_cpus_hardware
  
  validates_presence_of :co_cpu_name, :co_cpu_type, :manufacturer
  validates_uniqueness_of :co_cpu_name_id, :scope => :manufacturer_id
  
  named_scope :ordered, :order => 'co_cpu_name_id'
  
  acts_as_permalink :full_name
  
  SEARCH_FIELDS = {
    :name => 'co_cpu_name_id',
    :family => 'cpu_family_id',
    :manufacturer => 'manufacturers.name',
    :type => 'co_cpu_type_id'
  }
  
  def self.filter(params)
    conditions = [ilike_string, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'co_cpu_name_id'} #{params[:desc]}",
      :include => :manufacturer
    )
  end
  
  def self.ilike_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "COALESCE(#{field}, '')"
    end.join(' || ')
    "#{string} ILIKE ?"
  end
  
  def full_name
    name(:long)
  end
  
  def name(format=:short)
    case format
    when :long
      "#{name(:short)} #{co_cpu_type_id} co-processor"
    else :short
      "#{manufacturer.name} #{co_cpu_name_id}"
    end
  end
end
