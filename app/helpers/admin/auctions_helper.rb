module Admin::AuctionsHelper
  def final_price_string(auction)
    auction.final_price && sprintf("#{auction.currency_id} %.2f", auction.final_price)
  end
  
  def results_for(auction)
    auction.final_price ? final_price_string(auction) : 'no bids'
  end
end