class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  attr_accessor :uploaded_file
  
  validates_presence_of :original_filename, :imageable_id, :imageable_type
  
  FORMATS = { :thumb => 'x50', :small => 'x150', :normal => 'x400' }
  
  DB_PREFIX = '/images'
  FS_PREFIX = File.join(RAILS_ROOT, 'public', DB_PREFIX)
  
  def filename(format=:normal, prefix=:db)
    "#{prefix == :db ? DB_PREFIX : FS_PREFIX}/#{format.to_s}/#{original_filename}"
  end
  
  def title
    self[:title].blank? ? imageable.name : self[:title]
  end
end
