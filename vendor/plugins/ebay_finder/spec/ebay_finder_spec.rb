require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

module EbayFinderHelper
  def ebay_request(params={})
    @ebay_request ||= EbayFinder::Request.new(params)
  end

  def xml_response_from_file(filename)
    EbayFinder::FindItemsResponse.new(File.read(File.dirname(__FILE__) + "/stubs/#{filename}"))
  end  
end

describe EbayFinder do
  include EbayFinderHelper
  
  describe 'a new Request instance' do
    
    it 'should have a default website' do
      ebay_request.website.should == 'EBAY-IT'
    end
    
    it 'should set app_id from ebay_config.yml file' do
      ebay_request.app_id.should == 'test_ebay_app_id'
    end
  end
  
  describe 'a FindItemsResponse instance' do
    describe 'from an empty items xml resultset' do
      before do
        @response = xml_response_from_file('empty.xml')
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
      
      it 'page_number should be zero' do
        @response.page_number.should be_zero
      end
    end
    
    describe 'from a single item xml resultset' do
      before do
        @response = xml_response_from_file('standard.xml')
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
        
        it 'should have EUR as current price currency' do
          @item.current_price[:currency].should == 'EUR'
        end
        
        it 'should have 28.2 as current price amount' do
          @item.current_price[:amount].should == 28.0
        end
        
        it 'should have a end time' do
          @item.end_time.should == Time.parse("2009-11-05T18:50:24.000Z")
          @item.end_time.hour.should == 18
        end
      end
    end
    
    describe 'from a request error xml resultset' do      
      it 'should raise a request error' do
        lambda do
          xml_response_from_file('request_error.xml')
        end.should raise_error(EbayFinder::RequestError)
      end
    end
   
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