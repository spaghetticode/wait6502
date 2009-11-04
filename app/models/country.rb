class Country < ActiveRecord::Base
  include ActsAsSingleColumn
  acts_as_single_column :name
  
  has_many :manufacturers
end
