class Peripheral < Hardware
  belongs_to :peripheral_type
  has_and_belongs_to_many :io_ports
  has_and_belongs_to_many :cpus
  has_and_belongs_to_many :builtin_storages
  
  validates_presence_of :peripheral_type
  
  named_scope :ordered, :order => 'name'
end
