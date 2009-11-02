class EbayKeyword < ActiveRecord::Base
  belongs_to :searchable, :polymorphic => true
  
  validates_presence_of :name, :searchable
  validates_uniqueness_of :name, :case_sensitive => false, :scope => :searchable_id
  
  named_scope :ordered, :order => 'name'
end
