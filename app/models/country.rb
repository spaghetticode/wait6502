class Country < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name

  has_many :manufacturers

  attr_accessor :flag_file

  validate_on_create :validate_flag, :unless => lambda{|c| c.flag_file.blank?}

  URL_PATH = '/images/flags'
  FS_PATH = File.join(RAILS_ROOT, 'public')

  before_create :save_flag
  after_destroy :delete_flag

  def flag
    has_flag? && flag_url
  end
  
  def flag_filename
    name && "#{name.downcase.gsub(' ', '_')}.png"
  end
  
  private
  
  def has_flag?
    name && File.file?(flag_path)
  end

  def flag_url
    File.join(URL_PATH, flag_filename)
  end

  def flag_path
    File.join(FS_PATH, flag_url)
  end

  def validate_flag
    unless flag_file && flag_file.content_type =~ /^image\/png$/
      errors.add(:flag_file, 'must be a png file')
      false
    end
  end

  def save_flag
    return if flag_file.blank?
    File.open(flag_path, 'wb') do |f|
      f.write flag_file.read
    end
  end

  def delete_flag
    File.delete(flag_path) if has_flag?
  end
end