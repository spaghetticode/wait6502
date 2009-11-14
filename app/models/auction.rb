class Auction < ActiveRecord::Base
  attr_accessor :image_file
  
  belongs_to :ebay_site
  belongs_to :hardware
  belongs_to :currency

  COMPLETENESSES = ['bare', 'complete', 'complete with extras', 'boxed', 'boxed with extras']
  COSMETIC_CONDITIONS = %w{poor average good mint}
  GALLERY_IMAGES_PATH = "#{RAILS_ROOT}/public/images/auctions"
  BLANK_IMAGE_URL = "/images/auctions/blank.png"
  SEARCH_FIELDS = {
    'hardware name' => 'hardware.name', 'title' => 'auctions.title',
    'ebay website' => 'ebay_site_id', 'cosmetic conditions' => 'cosmetic_conditions',
    'completeness' => 'completeness', 'price' => 'final_price', 'end time' => 'end_time'
  }
  # validations:
  validates_uniqueness_of :url, :item_id
  validates_presence_of :hardware, :ebay_site, :currency, :url, :item_id
  validates_presence_of :completeness, :cosmetic_conditions, :end_time, :item_id
  validates_inclusion_of :completeness, :in => COMPLETENESSES
  validates_inclusion_of :cosmetic_conditions, :in => COSMETIC_CONDITIONS
  
  # callbacks:
  before_create :save_gallery_image
  before_destroy :delete_gallery_image
  
  # named scopes:
  named_scope :ordered, :order => 'created_at'
  named_scope :active, lambda {{:conditions => ['end_time > ?', Time.now]}}
  named_scope :closed, lambda {{:conditions => ['end_time < ?', Time.now]}}
  named_scope :sold_in, lambda {|site| {:conditions => ['final_price is not null and ebay_site_id = ?', site]}}
  COSMETIC_CONDITIONS.each do |condition|
    named_scope condition, :conditions => {:cosmetic_conditions => condition}
  end
  COMPLETENESSES.each do |completeness|
    method_name = completeness.gsub(' ', '_')
    named_scope method_name, :conditions => {:completeness => completeness}
  end
  
  # class methods:
  def self.item_ids
    @item_ids = Auction.all(:select => :item_id).map(&:item_id)
  end
  
  def self.concat_fields
    SEARCH_FIELDS.values.inject([]) do |collection, field|
      collection << "IFNULL(CAST(#{field} AS CHAR), '')"
    end.join(', ')
  end
  
  # instance methods:
  def closed?
    end_time < Time.now
  end
  
  def set_final_price
    ebay_item = find_ebay_item
    if ebay_item.bid_count > 0
      update_attribute(:final_price, ebay_item.current_price.amount)
    end
  end
  
  def gallery_image_url
    if image_url
      "/images/auctions/#{item_id}.jpg" 
    else
      BLANK_IMAGE_URL
    end
  end
  
  private
  
  def find_ebay_item
    EbayFinder::Request.new(
      :item_id  => item_id,
      :callname => 'GetItemStatus',
      :website  => ebay_site_id
    ).response.items.first
  end
  
  def save_gallery_image
    return if image_url.blank?
    download_image
    save_image
  end
  
  def download_image
    uri = URI.parse(image_url)
    request = Net::HTTP.new(uri.host, uri.port)
    request.read_timeout = 3
    self.image_file = request.get(uri.request_uri).body
  end
  
  def save_image
    # I expect ebay auction numbers to be truly unique
    filename = "#{item_id}.jpg"
    path = "#{GALLERY_IMAGES_PATH}/#{filename}"
    File.open(path, 'wb') {|f| f.write image_file}
  end
  
  def delete_gallery_image
    if image_url
      path = "#{GALLERY_IMAGES_PATH}/#{item_id}.jpg"
      File.delete(path) if File.file?(path)
    end
  end
end
