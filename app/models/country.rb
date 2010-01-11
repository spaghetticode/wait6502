class Country < ActiveRecord::Base
  include ActsAsNaturalKey
  acts_as_natural_key :name

  has_many :manufacturers
  has_many :ebay_sites
  has_many :original_prices
  
  has_attached_file :flag,
    :styles => {:original => '60x40'},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_headers => {'Cache-Control' => 'max-age=315360000', 'Expires' => 'Never expire'},
    :path => ':class/:id/flag.:extension',
    :default_url => '/images/blank_flag.jpg'

  def unused?
    manufacturers.empty? && ebay_sites.empty? && original_prices.empty?
  end
end