class OriginalPrice < ActiveRecord::Base
  belongs_to :currency
  belongs_to :country
  belongs_to :purchaseable, :polymorphic => true
  
  validates_numericality_of :amount
  validates_presence_of :currency, :country, :purchaseable_id, :purchaseable_type, :date, :amount
  
  named_scope :ordered, :order => 'countries.name, amount', :include => :country
  named_scope :tainted, :conditions => {:tainted => true}
  named_scope :untainted, :conditions => {:tainted => nil}
end
