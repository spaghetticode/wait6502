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
end
