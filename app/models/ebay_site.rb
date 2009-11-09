class EbaySite < ActiveRecord::Base
  # no scaffold is provided to add/remove values from this table,
  # as data is supposed to be entered via rake db:seed command and
  # is not supposed to change.
  include ActsAsNaturalKey
  acts_as_natural_key :name
end
