class BuiltinStorage < ActiveRecord::Base
  belongs_to :storage_name
  belongs_to :storage_size
  belongs_to :storage_format
  has_and_belongs_to_many :computers
  has_and_belongs_to_many :peripherals
  
  validates_presence_of :storage_name_id
  validates_uniqueness_of :storage_name_id, :scope => [:storage_format_id, :storage_size_id]
  
  named_scope :ordered, :order => 'storage_name_id'
  
  def full_name
    "#{storage_name_id} #{storage_format_id} #{storage_size_id}"
  end
end
