class EbaySite < ActiveRecord::Base
  include ActsAsSingleColumn
  acts_as_single_column :name
end
