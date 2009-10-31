class Peripheral < Hardware
  include HardwareCommonAssociations

  belongs_to :peripheral_type
  has_many :original_prices, :as => :purchaseable
  has_many :images, :as => :imageable
  
  validates_presence_of :peripheral_type
  
  named_scope :ordered, :order => 'name'
end
