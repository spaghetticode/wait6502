class OperativeSystem < ActiveRecord::Base
  has_and_belongs_to_many :computers
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  named_scope :ordered, :order => 'name'
  
  def full_name
    name
  end
end
