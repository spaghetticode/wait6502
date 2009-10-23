class Computer < Hardware
  belongs_to :computer_type
  has_and_belongs_to_many :cpus
  has_and_belongs_to_many :builtin_storages
  has_and_belongs_to_many :operative_systems
  has_and_belongs_to_many :co_cpus
  has_and_belongs_to_many :io_ports
  
  validates_presence_of :computer_type
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, hardware.name'
end
