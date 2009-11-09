require 'spec_helper'

module ResultsetHelper
  def ebay_response_from(filename)
    xml_mock = "#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/#{filename}"
    EbayFinder::FindItemsAdvancedResponse.new(xml_mock)
  end

  def stub_ebay_response(filename)
    response = ebay_response_from(filename)
    mock = mock_model(EbayFinder::Request, :response => response)
    EbayFinder::Request.stub!(:new => mock)
  end
end

describe Resultset do
  include ResultsetHelper
    
  describe 'when no matching auction is found on ebay' do
    before do
      stub_ebay_response('FindItemsAdvancedResponse0Items.xml')
    end
    
    describe 'the created resultset' do
      before do
        @resultset = Resultset.new
      end
      
      it 'should have no items' do
        @resultset.total_items.should be_zero
      end
    
      it 'should have no items' do
        @resultset.items.should be_empty
      end
    end
  end
  
  describe 'when one matching auction is found on ebay' do
    before do
      stub_ebay_response('FindItemsAdvancedResponse1Item.xml')
    end
    
    describe 'the created resultset' do
      before do
        @resultset = Resultset.new
      end
      
      it 'should have 1 item' do
        @resultset.total_items.should == 1
      end
    
      describe 'should have a item that' do
        before do
          @item = @resultset.items.first
        end
        
        it 'should have expected item_id' do
          @item.item_id.should == '170402561257'
        end
      
        it 'should have expected title' do
          @item.title.should == "COMMODORE AMIGA 1000 + MEMORY + GAMES ORIGINAL BOX"
        end
      end
    end
  end
end