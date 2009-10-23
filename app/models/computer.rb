class Computer < Hardware
  belongs_to :computer_type
  
  validates_presence_of :computer_type
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, hardware.name'
end
