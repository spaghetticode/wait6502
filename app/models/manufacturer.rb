class Manufacturer < ActiveRecord::Base
  belongs_to :country
  has_many :hardware
  has_many :cpus
  has_many :co_cpus
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  acts_as_permalink :name
    
  has_attached_file :logo,
    :styles => {:original => 'x40'},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_headers => {'Cache-Control' => 'max-age=315360000', 'Expires' => 'Never expire'},
    :path => ':class/:id/:timestamp.:extension',
    :default_url => '/images/blank_manufacturer.jpg'
    
  named_scope :ordered, :order => 'name'
  
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
  
  def self.to_select
    ordered.map do |manufacturer|
      [manufacturer.name,  manufacturer.id]
    end
  end
  
  def stamp
    Time.now.to_s(:db).gsub(/\D/, '')
  end
end
