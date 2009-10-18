class Currency < ActiveRecord::Base
  validates_presence_of :code, :symbol
  validates_uniqueness_of :code, :case_sensitive => false
  
  named_scope :ordered, :order => 'code'
end
