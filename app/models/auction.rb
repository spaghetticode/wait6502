class Auction < ActiveRecord::Base
  attr_accessor :image_file
  
  belongs_to :ebay_site
  belongs_to :hardware
  belongs_to :currency
  
  Auction::BLANK_IMAGE_URL = '/images/blank_auction.png'

  has_attached_file :picture,
    :styles => {:original => '60x60'},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :path => ':class/:id/picture.:extension',
    :default_url => BLANK_IMAGE_URL
    
  before_create :attach_picture
    
  COMPLETENESSES = ['bare', 'complete', 'complete with extras', 'boxed', 'boxed with extras']
  COSMETIC_CONDITIONS = %w{poor average good mint}
  
  validates_uniqueness_of :url, :item_id
  validates_presence_of :hardware, :ebay_site, :currency, :url, :item_id
  validates_presence_of :completeness, :cosmetic_conditions, :end_time, :item_id
  validates_inclusion_of :completeness, :in => COMPLETENESSES
  validates_inclusion_of :cosmetic_conditions, :in => COSMETIC_CONDITIONS
  
  SEARCH_FIELDS = {
    'hardware name' => 'hardware.name', 'title' => 'auctions.title',
    'ebay website' => 'ebay_site_id', 'cosmetic conditions' => 'cosmetic_conditions',
    'completeness' => 'completeness', 'price' => 'final_price', 'end time' => 'end_time'
  }

  named_scope :ordered, :order => 'created_at'
  named_scope :active, lambda {{:conditions => ['end_time > ?', Time.now.utc]}}
  named_scope :closed, lambda {{:conditions => ['end_time < ?', Time.now.utc]}}
  named_scope :sold_in, lambda {|site| {:conditions => ['final_price is not null and ebay_site_id = ?', site]}}
  
  COSMETIC_CONDITIONS.each do |condition|
    named_scope condition, :conditions => {:cosmetic_conditions => condition}
  end
  
  COMPLETENESSES.each do |completeness|
    method_name = completeness.gsub(' ', '_')
    named_scope method_name, :conditions => {:completeness => completeness}
  end
  
  # class methods:
  def self.filter(params)
    conditions = [ilike_string, "%#{params[:keywords]}%"] if params[:keywords]
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'end_time'} #{params[:desc]}",
      :include => :hardware
    )
  end
  
  def self.item_ids
    @item_ids = Auction.all(:select => :item_id).map(&:item_id)
  end
  
  def self.ilike_string
    "COALESCE(hardware.name, '') || COALESCE(auctions.title, '') || 
     COALESCE(ebay_site_id, '') || COALESCE(cosmetic_conditions, '') ||
     COALESCE(completeness, '') || COALESCE(TO_CHAR(final_price, ''), '') || 
     COALESCE(TO_CHAR(end_time, ''),'') ILIKE ?"
  end
  
  # instance methods:
  def closed?
    end_time < Time.now.utc
  end
  
  def set_final_price
    ebay_item = find_ebay_item
    if ebay_item.bid_count > 0
      update_attribute(:final_price, ebay_item.current_price.amount)
    end
  end
  
  def attach_picture
    self.picture = fake_uploaded_file if image_url
  end
  
  def recent?
    end_time + 90.days > Date.today
  end
  
  def to_pdf
    PDFKit.new(url).to_pdf
  end
  
  def pdf_filename
    "#{hardware_parameterized_name}-#{ebay_site_name}-#{item_id}.pdf" rescue nil
  end
  
  def hardware_parameterized_name
    hardware.parameterized_name
  end
  
  def ebay_site_name
    ebay_site.name
  end
  
  private
  
  def fake_uploaded_file
    returning ActionController::UploadedStringIO.new(download_image_data) do |file|
      file.content_type = "image/jpg"
      file.original_path = image_url
    end
  end
  
  def download_image_data
    uri = URI.parse(image_url)
    request = Net::HTTP.new(uri.host, uri.port)
    request.read_timeout = 3
    request.get(uri.request_uri).body
  end
  
  def find_ebay_item
    EbayFinder::Request.new(
      :item_id  => item_id,
      :callname => 'GetItemStatus',
      :website  => ebay_site_id
    ).response.items.first
  end
end
