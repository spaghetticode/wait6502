class Auction < ActiveRecord::Base
  belongs_to :ebay_site
  belongs_to :hardware
  belongs_to :currency

  COMPLETENESSES = ['bare', 'complete', 'complete with extras', 'boxed', 'boxed with extras']
  COSMETIC_CONDITIONS = %w{bare average good mint}
    
  validates_uniqueness_of :url, :item_id
  validates_presence_of :hardware, :ebay_site, :currency
  validates_presence_of :completeness, :cosmetic_conditions, :end_time, :item_id
  
  validates_inclusion_of :completeness, :in => COMPLETENESSES
  validates_inclusion_of :cosmetic_conditions, :in => COSMETIC_CONDITIONS
  
  def closed?
    end_time < Time.now
  end
  
  def closed_or_end_time
    closed? ? 'closed' : end_time.to_s(:short)
  end
  
  def set_final_price
    ebay_item = find_ebay_item
    if ebay_item.bid_count > 0
      update_attribute(:final_price_value, ebay_item.current_price['content'])
    end
  end
  
  private
  
  def find_ebay_item
    EbayFinder::Request.new(:item_id => item_id, :callname => 'GetItemStatus').response.items.first
  end
end
