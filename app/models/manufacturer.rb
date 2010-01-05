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
    :path => ':class/:id/logo.:extension'

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
end
