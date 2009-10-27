class IoPort < ActiveRecord::Base
  has_and_belongs_to_many :computers
  has_and_belongs_to_many :peripherals
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :connector
  
  named_scope :ordered, :order => 'name'
  # TODO valutare se tirare fuori name/connector
  
  def full_name
    "#{name} (#{connector} connector)"
  end
end
