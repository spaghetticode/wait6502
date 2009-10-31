class Peripheral < Hardware
  include HardwareCommonAssociations

  belongs_to :peripheral_type
  has_many :original_prices, :as => :purchaseable
  
  validates_presence_of :peripheral_type
  
  named_scope :ordered, :order => 'name'
end
