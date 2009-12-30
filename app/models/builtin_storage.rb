class BuiltinStorage < ActiveRecord::Base
  belongs_to :storage_name
  belongs_to :storage_size
  belongs_to :storage_format
  has_and_belongs_to_many :hardware, :join_table => :builtin_storages_hardware
  
  validates_presence_of :storage_name_id
  validates_uniqueness_of :storage_name_id, :scope => [:storage_format_id, :storage_size_id]
  
  named_scope :ordered, :order => 'storage_name_id'
  
  acts_as_permalink :full_name
  
  SEARCH_FIELDS = {
    :name => 'storage_name_id',
    :format => 'storage_format_id',
    :size => 'storage_size_id'
  }
  
  def self.filter(params)
    conditions = [self.concat_string, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'storage_name_id'} #{params[:desc]}"
    )
  end
  
  def self.concat_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "IFNULL(#{field}, '')"
    end.join(', ')
    "concat(#{string}) like ?"
  end
    
  def full_name
    size_string = storage_size_id.blank? ? '' : "#{storage_size_id} "
    "#{size_string}#{storage_format_id} #{storage_name_id}"
  end
end
