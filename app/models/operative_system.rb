class OperativeSystem < ActiveRecord::Base
  has_and_belongs_to_many :hardware, :join_table => :hardware_operative_systems
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  named_scope :ordered, :order => 'name'
  
  acts_as_permalink :full_name
  
  def full_name
    name
  end
end
