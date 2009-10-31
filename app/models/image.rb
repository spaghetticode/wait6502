class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  attr_accessor :uploaded_file, :original_file
  
  validates_presence_of :imageable_id, :imageable_type
  validate_on_create :validate_file_format
  
  before_create :save_files
  before_destroy :delete_files
  
  FORMATS = { :thumb => 'x50', :small => 'x150', :normal => 'x400' }
  
  DB_PREFIX = '/images'
  FS_PREFIX = File.join(RAILS_ROOT, 'public', DB_PREFIX)
  
  def filename(format=:normal, prefix=:db)
    "#{prefix == :db ? DB_PREFIX : FS_PREFIX}/#{format.to_s}/#{original_filename}"
  end
  
  def title
    self[:title].blank? ? imageable.name : self[:title]
  end
  
  private
  
  def validate_file_format
    unless uploaded_file && uploaded_file.content_type =~/^image\/\w{3,4}/
      errors.add(:uploaded_file, 'must be an image file (JPG, PNG, GIF)')
      false
    end
  end
  
  def save_files
    set_original_filename
    save_original_file
    FORMATS.each do |format, size|
      system "convert -resize #{size} '#{original_file}' '#{filename(format, :fs)}'"
    end
  end
  
  def delete_files
    FORMATS.keys.each do |format|
      File.delete(filename(format, :fs))
    end      
  end
  
  def set_original_filename
    self.original_filename = "#{Time.now.to_s(:number)}_#{uploaded_file.original_filename}"
  end
  
  def save_original_file
    self.original_file = File.join(FS_PREFIX, 'original', original_filename)
    File.open(@original_file, 'wb') do |f|
      while !uploaded_file.eof
        f.write uploaded_file.read(4096)
      end
    end
  end
  
end
