class Country < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name

  has_many :manufacturers
  
  attr_accessor :flag_image
  
  with_options  :unless => lambda{|c| c.flag_filename.blank?} do |klass|
    klass.validates_format_of :flag_filename, :with => /^[a-z]{2}$/
    klass.validate_on_create :validate_file_format
  end
  
  URL_PATH = '/images/flags'
  FS_PATH = File.join(RAILS_ROOT, 'public')
  
  before_create :save_flag_image
  after_destroy :delete_flag_image
  
  def flag_image_filename
    flag_filename && File.join(URL_PATH, "#{flag_filename}.png")
  end
  
  private
  
  def validate_file_format
    unless flag_image && flag_image.content_type =~ /^image\/png$/
        errors.add(:flag_image, 'must be a png file')
        false
    end
  end
  
  def save_flag_image
    return if flag_filename.blank?
    path = File.join(FS_PATH, flag_image_filename)
    File.open(path, 'wb') do |f|
      f.write flag_image.read
    end
  end
  
  def delete_flag_image
    return if flag_filename.blank?
    path = File.join(FS_PATH, flag_image_filename)
    File.delete(path) if File.file?(path)
  end
end
