class BuiltinLanguage < ActiveRecord::Base
  include ActsAsSingleColumn
  acts_as_single_column :name
  
  has_many :computers
end
