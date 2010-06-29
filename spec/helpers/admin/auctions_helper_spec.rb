require 'spec_helper'
include ActionController::Streaming

describe Admin::AuctionsHelper do
  describe 'FINAL_PRICE_STRING' do
    it 'should return nil when final_price is not set' do
      auction = mock(Auction, :final_price => nil)
      helper.final_price_string(auction).should be_nil
    end
    
    it 'should return a price string with currency and 2 decimals' do
      auction = mock_model(Auction, :final_price => 10.2, :currency_id => 'Euro')
      helper.final_price_string(auction).should == 'Euro 10.20'
    end
  end
  
  describe 'RESULTS_FOR' do
    it 'should return "no bids" when auction has no final price' do
      auction = mock(Auction, :final_price => nil)
      helper.results_for(auction).should == 'no bids'
    end
    
    it 'should return final_price_string when auction has a final price' do
      auction = mock_model(Auction, :final_price => 10.2, :currency_id => 'Euro')
      helper.results_for(auction).should == helper.final_price_string(auction)
    end
  end
end