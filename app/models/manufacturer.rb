class Manufacturer < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  belongs_to :country
  
  named_scope :ordered, :order => 'name'
end