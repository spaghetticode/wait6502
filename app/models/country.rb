class Country < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name
  
  has_many :manufacturers
end
