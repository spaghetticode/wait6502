class IoPort < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :connector
  named_scope :ordered, :order => 'name'
  # TODO valutare se tirare fuori name/connector
end
