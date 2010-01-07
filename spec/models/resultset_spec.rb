require 'spec_helper'

module ResultsetHelper
  def ebay_response(filename)
    xml = File.read("#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/#{filename}")
    EbayFinder::FindItemsAdvancedResponse.new(xml)
  end

  def stub_ebay_request(filename)
    response = ebay_response(filename)
    request = mock(EbayFinder::Request, :response => response)
    EbayFinder::Request.stub!(:new => request)
  end
end

describe Resultset do
  include ResultsetHelper
  
  describe 'a blank resultset' do
    before do
      @resulset = Resultset.new
    end
    
    it 'ebay_site should not be nil' do
      @resulset.ebay_site.should_not be_nil
    end
    
    it 'ebay_site should be US' do
      @resulset.ebay_site.should == 'US'
    end
    
    it 'max_entries should be 100' do
      @resulset.max_entries.should == 100
    end
    
    it 'pagen_number should be 1' do
      @resulset.page_number.should  == 1
    end
    
    it 'category_id should be nil' do
      @resulset.category_id.should be_nil
    end
    
    it 'keywords should be nil' do
      @resulset.keywords.should be_nil
    end
  end
  
  context 'a resultset with no results' do    
    before do
      stub_ebay_request('FindItemsAdvancedResponse0Items.xml')
      @resultset = Resultset.new
      @resultset.set_results
    end
    
    it 'should have no item' do
      @resultset.items.should be_empty
    end
  end
  
  context 'a resultset with 10 results' do
    before do
      stub_ebay_request('FindItemsAdvancedResponse10Items.xml')
      @resultset = Resultset.new
      @resultset.set_results
    end
    
    it 'should have items' do
      @resultset.items.should have_at_least(1).item
    end
  end
  
  context 'a resultset with 1 item' do
    before do
      stub_ebay_request('FindItemsAdvancedResponse1Item.xml')
      @resultset = Resultset.new
      @resultset.set_results
    end
    
    it 'should have 1 item' do
      @resultset.items.should have_exactly(1).item
    end
    
    context 'the item' do
      before do
        @item = @resultset.items.first
      end
      
      it 'should have expected price string' do
        @item.current_price.to_s.should == 'EUR 499.00'
      end
    end
  end
end