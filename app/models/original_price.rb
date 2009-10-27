class OriginalPrice < ActiveRecord::Base
  belongs_to :currency
  belongs_to :country
  
  belongs_to :purchasable, :polymorphic => true
  
  validates_presence_of :currency, :country, :purchasable_id, :purchasable_type, :date, :amount
end
