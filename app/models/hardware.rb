class Hardware < ActiveRecord::Base
  set_table_name :hardware
  
  has_many :original_prices, :as => :purchaseable
  has_many :images, :as => :imageable
  has_many :ebay_keywords, :as => :searchable
  belongs_to :manufacturer
  
  validates_presence_of :name, :manufacturer
  validates_uniqueness_of :name, :scope => [:manufacturer_id, :code], :case_sensitive => false
end
