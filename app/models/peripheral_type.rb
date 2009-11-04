class PeripheralType < ActiveRecord::Base
  include ActsAsSingleColumn
  acts_as_single_column :name
  
  has_many :peripherals
end
