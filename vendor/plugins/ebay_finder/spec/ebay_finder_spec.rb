require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

module EbayFinderHelper
  def ebay_request(params={})
    @ebay_request ||= EbayFinder::Request.new(params)
  end

  def xml_response_from_file(filename, klass=EbayFinder::FindItemsAdvancedResponse)
    klass.new(File.read(File.dirname(__FILE__) + "/stubs/#{filename}"))
  end  
end

describe EbayFinder do
  include EbayFinderHelper
  
  describe 'a new Request instance' do
    
    it 'should have a default website' do
      ebay_request.website.should == '0'
    end
    
    it 'should set app_id from ebay_config.yml file' do
      ebay_request.app_id.should == 'test_ebay_app_id'
    end
  end
  
  describe 'a FindItemsAdvancedResponse instance' do
    describe 'from an empty items xml resultset' do
      before do
        @response = xml_response_from_file('FindItemsAdvancedResponse0Items.xml')
      end

      it 'xml_items should be nil' do
        @response.xml_items.should be_nil
      end
              
      it 'items should be empty' do
        @response.items.should be_empty
      end
      
      it 'total_items should be zero ' do
        @response.total_items.should be_zero
      end
      
      it 'total_pages should be zero' do
        @response.total_pages.should  be_zero
      end
      
      it 'page_number should be 1' do
        @response.page_number.should == 1
      end
    end
    
    describe 'from a single item xml resultset' do
      before do
        @response = xml_response_from_file('FindItemsAdvancedResponse1Item.xml')
      end
      
      it 'xml_items should be an hash' do
        @response.xml_items.should be_a(Hash)
      end
      
      it 'total_items should be 1' do
        @response.total_items.should == 1
      end
      
      it 'items should have 1 item' do
        @response.items.should have(1).item
      end
      
      it 'total_pages should be 1' do
        @response.total_pages.should == 1
      end
      
      it 'page_number should be 1' do
        @response.page_number.should == 1
      end
      
      describe 'the expected item' do
        before do
          @item = @response.items.first
        end
        
        it 'should return a Money object as current_price' do
          @item.current_price.should be_a(EbayFinder::Money)
        end
        
        it 'should have EUR as current price currency id' do
          @item.current_price.currency_id.should == 'EUR'
        end
        
        it 'should have 499.0 as current price amount' do
          @item.current_price.amount.should == 499.0
        end
        
        it 'should have a end time' do
          @item.end_time.should == Time.parse("2009-12-03T20:10:27.000Z")
        end
      end
    end
    
    describe 'from a 10 items xml resultset' do
      before do
        @response = xml_response_from_file('FindItemsAdvancedResponse10Items.xml')
      end
      
      it 'should find 9 items' do
        @response.items.should have(10).items
      end
    end
    
    describe 'from a failure xml resultset' do
      it 'should raise a request error' do
        lambda do
          @response = xml_response_from_file('FindItemsAdvancedFailure.xml')
        end.should raise_error(EbayFinder::RequestError)
      end
    end          
  end
  
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
  
  describe 'a response instance' do
    describe 'from a timeout error xml resultset' do
      it 'should raise a timeout error' do
        lambda do
          xml_response_from_file('timeout_error.xml')
        end.should raise_error(TimeoutError)
      end
    end
    
    describe 'from a system error xml resultset' do
      it 'should raise a system error' do
        lambda do
          xml_response_from_file('system_error.xml')
        end.should raise_error(EbayFinder::SystemError)
      end
    end
  end
end