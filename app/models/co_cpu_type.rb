class CoCpuType < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name
end
