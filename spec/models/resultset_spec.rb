require 'spec_helper'

module ResultsetHelper
  def ebay_response_from(filename)
    xml_mock = "#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/#{filename}"
    EbayFinder::FindItemsResponse.new(xml_mock)
  end

  def mock_resultset(params={})
    return @resultset if @resultset
    response = ebay_response_from(params[:file])
    mock = mock_model(EbayFinder::Request, :response => response)
    EbayFinder::Request.stub!(:new => mock)
    @resultset = Resultset.new(params)
  end
  
  def mock_item
    mock_resultset.items.first
  end
end

describe Resultset do
  include ResultsetHelper
  
  describe 'when no item is found' do
    before do
      mock_resultset(:file => 'empty.xml')
    end
    
    it 'should have no items' do
      mock_resultset.total_items.should be_zero
    end
    
    it 'should have no items' do
      mock_resultset.items.should be_empty
    end
  end
  
  describe 'when one item is found' do
    before do
      mock_resultset(:file => 'standard.xml')
    end
    
    it 'total_items should return 1' do
      mock_resultset.total_items.should == 1
    end
    
    it 'should have an item' do
      mock_resultset.items.first.should be_a(EbayFinder::Item)
    end
    
    describe 'found item' do
      it 'should have expected item_id' do
        mock_item.item_id.should == '250509847328'
      end
      
      it 'should have expected title' do
        mock_item.title.should == "Libro Manule Introduzione all'MSX BASIC ( Sony ) rarità"
      end
    end
  end
end