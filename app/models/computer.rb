class Computer < Hardware
  belongs_to :computer_type
  has_and_belongs_to_many :cpus
  has_and_belongs_to_many :builtin_storages
  
  validates_presence_of :computer_type
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, hardware.name'
end
