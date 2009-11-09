class HardwareType < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name
  
  has_many :hardware
end
