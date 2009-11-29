class Currency < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name
  
  has_many :original_prices
  has_many :auctions
  has_many :ebay_sites
  
  def unused?
    ebay_sites.empty? && original_prices.empty? && auctions.empty?
  end
end
