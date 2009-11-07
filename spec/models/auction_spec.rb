require 'spec_helper'

describe Auction do
  context 'a new blank instance' do
    it 'should not be valid' do
      Auction.new.should_not be_valid
    end
    
    it 'should require a hardware' do
      Auction.new.should have(1).error_on(:hardware)
    end
    
    it 'should require a currency' do
      Auction.new.should have(1).error_on(:currency)
    end
    
    it 'should require a ebay_site' do
      Auction.new.should have(1).error_on(:ebay_site)
    end
    
    it 'should require cosmetic_conditions' do
      Auction.new.should have_at_least(1).error_on(:cosmetic_conditions)
    end
    
    it 'should require completeness' do
      Auction.new.should have_at_least(1).error_on(:completeness)
    end
    
    it 'should require end_time' do
      Auction.new.should have(1).error_on(:end_time)
    end
    
    it 'should require a item_id' do
      Auction.new.should have(1).error_on(:item_id)
    end
    
    it 'should require a valid completeness' do
      Auction.new(:completeness => 'invalid value').should have(1).error_on(:completeness)
    end
    
    it 'should require a  valid cosmetic_conditions' do
      Auction.new(:cosmetic_conditions => 'invalid value').should have(1).error_on(:cosmetic_conditions)
    end
    
    it 'should have expected associations' do
      %w{hardware ebay_site currency}.each do |association|
        Auction.new.should respond_to(association)
      end
    end

    it 'should have a unique url' do
      auction = Factory(:auction)
      invalid = Auction.new(:url => auction.url)
      invalid.should have(1).error_on(:url)
    end
    
    it 'should have a unique item_id' do
      auction = Factory(:auction)
      invalid = Auction.new(:item_id => auction.item_id)
      invalid.should have(1).error_on(:item_id)
    end
  end
  
  context 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:auction).should be_valid
    end
    
    context 'when not closed yet' do
      before do
        @auction = Factory(:auction)
      end
      
      it 'should not be closed' do
        @auction.should_not be_closed
      end
      
      it 'closed_or_end_time should return end_time' do
        @auction.closed_or_end_time.should == @auction.end_time.to_s(:short)
      end
    end
    
    context 'when closed' do
      before do
        @auction = Factory(:auction, :end_time => Time.now.yesterday)
      end
      
      it 'should be closed' do
        @auction.should be_closed
      end
      
      it 'closed_or_end_time should return closed' do
        @auction.closed_or_end_time.should == 'closed'
      end
    end
  end
end
