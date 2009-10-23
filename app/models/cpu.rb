class Cpu < ActiveRecord::Base
  belongs_to :cpu_name
  belongs_to :cpu_family
  belongs_to :cpu_bit
  belongs_to :manufacturer
  has_and_belongs_to_many :computers
  
  validates_presence_of :cpu_name, :cpu_bit, :manufacturer
  validates_uniqueness_of :cpu_name_id, :scope => [:manufacturer_id, :clock]
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, cpu_name_id'
  
  def full_name
    clock = self.clock.blank? ? '' : "@#{self.clock}"
    "#{manufacturer.name} #{cpu_name_id} #{clock}, #{cpu_bit_id} #{cpu_family_id} family"
  end
end
