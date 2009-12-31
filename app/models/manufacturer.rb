class Manufacturer < ActiveRecord::Base
  belongs_to :country
  has_many :hardware
  has_many :cpus
  has_many :co_cpus
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  attr_accessor :logo_file
  
  validate_on_create :validate_logo, :unless => lambda{|m| m.logo_file.blank?}
  
  named_scope :ordered, :order => 'name'
  
  before_save :save_logo
  after_destroy :delete_logo
  
  acts_as_permalink :name
  
  URL_PATH = '/images/manufacturers'
  FS_PATH = File.join(RAILS_ROOT, 'public')
  SEARCH_FIELDS = { :name => 'manufacturers.name', :country => 'countries.name'}
  
  def self.filter(params)
    conditions = [Manufacturer.ilike_string, "%#{params[:keywords]}%"] if params[:keywords]
    all(
      :conditions => conditions, 
      :order => "#{params[:order] || 'manufacturers.name'} #{params[:desc]}",
      :include => :country
    )
  end
  
  def self.ilike_string
    string  = SEARCH_FIELDS.values.inject([]) do |fields, field|
      fields << "COALESCE(#{field}, '')"
    end
    "#{string.join(' || ')} ILIKE ?"
  end
  
  def logo
    has_logo? ? logo_url : nil
  end
  
  def logo_filename
    name && "#{name.downcase.gsub(' ', '_')}.png"
  end
  
  private
  
  def has_logo?
    name && File.file?(logo_path)
  end
  
  def logo_url
    File.join(URL_PATH, logo_filename)
  end
  
  def logo_path
    File.join(FS_PATH, logo_url)
  end
  
  def validate_logo
    unless logo_file && logo_file.content_type =~ /^image\/png$/
      errors.add(:logo_file, 'must be a png image')
      false
    end
  end
  
  def save_logo
    return if logo_file.blank?
    File.open(logo_path, 'wb') do |f|
      f.write logo_file.read
    end
  end
  
  def delete_logo
    File.delete(logo_path) if has_logo?
  end
end
