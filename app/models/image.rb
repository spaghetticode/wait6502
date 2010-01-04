class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  attr_accessor :uploaded_file
  
  validates_presence_of :imageable_id, :imageable_type, :uploaded_file
  validate_on_create    :validate_file_format
  
  before_create  :save_files
  before_destroy :delete_files
  
  FORMATS = { :thumb => 'x50', :small => 'x150', :normal => 'x400' }
  
  DB_PREFIX = '/images'
  FS_PREFIX = File.join(RAILS_ROOT, 'public', DB_PREFIX)
  
  def filename(format=:normal, prefix=:db)
    "#{prefix == :db ? DB_PREFIX : FS_PREFIX}/#{format}/#{original_filename}"
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
    set_filenames
    save_original_image
    save_resized_images
  end
  
  def delete_files
    FORMATS.keys.each do |format|
      file = filename(format, :fs)
      File.delete(file) if File.file?(file)
    end      
  end
  
  def set_filenames
    self.original_filename = "#{Time.now.to_s(:number)}_#{uploaded_file.original_filename}"
    @original_file = File.join(FS_PREFIX, 'original', original_filename)
  end
  
  def save_original_image
    File.open(@original_file, 'wb') do |file|
      until uploaded_file.eof
        file.write uploaded_file.read(4096)
      end
    end
  end
  
  def save_resized_images
    FORMATS.each do |format, size|
      system "#{::CONVERT_PATH}convert -resize #{size} '#{@original_file}' '#{filename(format, :fs)}'"
    end
  end
end
