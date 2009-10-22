class CoCpu < ActiveRecord::Base
  belongs_to :co_cpu_name
  belongs_to :co_cpu_type
  belongs_to :manufacturer
  
  validates_presence_of :co_cpu_name, :co_cpu_type, :manufacturer
  validates_uniqueness_of :co_cpu_name_id, :scope => :manufacturer_id
  
  named_scope :ordered, :order => 'co_cpu_name_id'
end
