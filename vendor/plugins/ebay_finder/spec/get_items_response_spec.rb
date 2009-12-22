require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
require File.dirname(__FILE__) + '/ebay_finder_helper'

describe EbayFinder::GetItemStatusResponse do
  include EbayFinderHelper
  
  describe 'a GetItemStatusResponse instance' do
    describe 'from a single item xml resultset' do
      before do
        @response = xml_response_from_file('getItemStatus1Item.xml', EbayFinder::GetItemStatusResponse)
      end
  
      it 'should find 1 item' do
        @response.items.should have(1).item
      end
      
      it 'should have 1 total_items' do
        @response.total_items.should == 1
      end
  
      describe 'found item' do
        before do
          @item = @response.items.first
        end
        
        it 'should have a end_time attribute' do
          @item.end_time.should == Time.parse('2009-12-03T20:10:27.000Z')
        end
        
        it 'should have active listing_status' do
          @item.listing_status.should == 'Active'
        end
        
        it 'should have a Money object current_price' do
          @item.current_price.should be_a(EbayFinder::Money)
        end
      end
    end
  
    describe 'from a 2 items xml resultset' do
      before do
        @response = xml_response_from_file('getItemStatus2Items.xml', EbayFinder::GetItemStatusResponse)
      end
      
      it 'should find 2 items' do
        @response.items.should have(2).items
      end
      
      it 'should return 2 as total_items' do
        @response.total_items.should == 2
      end
      
      it 'each found item should have an active listing_status' do
        @response.items.each do |item|
          item.listing_status.should == 'Active'
        end
      end
    end
  
    describe 'from a failure xml resultset' do
      it 'should raise an error' do
        lambda do
          @response = xml_response_from_file('getItemStatusFailure.xml', EbayFinder::GetItemStatusResponse)
        end.should raise_error(EbayFinder::RequestError)
      end
    end
  end
end