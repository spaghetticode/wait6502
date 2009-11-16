class BuiltinStorage < ActiveRecord::Base
  belongs_to :storage_name
  belongs_to :storage_size
  belongs_to :storage_format
  has_and_belongs_to_many :hardware, :join_table => :builtin_storages_hardware
  
  validates_presence_of :storage_name_id
  validates_uniqueness_of :storage_name_id, :scope => [:storage_format_id, :storage_size_id]
  
  named_scope :ordered, :order => 'storage_name_id'
  
  SEARCH_FIELDS = {
    :name => 'storage_name_id',
    :format => 'storage_format_id',
    :size => 'storage_size_id'
  }
  
  def self.concat_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "IFNULL(#{field}, '')"
    end.join(', ')
    "concat(#{string}) like ?"
  end
    
  def full_name
    "#{storage_name_id} #{storage_format_id} #{storage_size_id}"
  end
end
