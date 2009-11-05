class Manufacturer < ActiveRecord::Base
  belongs_to :country
  has_many :hardware
  has_many :cpus
  has_many :co_cpus
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  named_scope :ordered, :order => 'name'
end
