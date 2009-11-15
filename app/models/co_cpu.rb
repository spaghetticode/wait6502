class CoCpu < ActiveRecord::Base
  belongs_to :co_cpu_name
  belongs_to :co_cpu_type
  belongs_to :cpu_family
  belongs_to :manufacturer
  has_and_belongs_to_many :hardware, :join_table => :co_cpus_hardware
  
  validates_presence_of :co_cpu_name, :co_cpu_type, :manufacturer
  validates_uniqueness_of :co_cpu_name_id, :scope => :manufacturer_id
  
  named_scope :ordered, :order => 'co_cpu_name_id'
  
  SEARCH_FIELDS = {
    :name => 'co_cpu_name_id', :family => 'cpu_family_id',
    :manufacturer => 'manufacturers.name', :type => 'co_cpu_type_id'
  }
  
  def self.concat_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "IFNULL(#{field}, '')"
    end.join(', ')
    "concat(#{string}) like ?"
  end
  
  def full_name
    "#{manufacturer.name} #{co_cpu_name_id} #{co_cpu_type_id} co-processor"
  end
  
end
