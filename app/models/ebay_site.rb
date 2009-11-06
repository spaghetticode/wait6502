class EbaySite < ActiveRecord::Base
  # no scaffold is provided to add/remove values from this table,
  # as data is supposed to be entered via rake db:seed command and
  # is not supposed to change.
  include ActsAsSingleColumn
  acts_as_single_column :name
end
