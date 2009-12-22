require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
require File.dirname(__FILE__) + '/ebay_finder_helper'

describe EbayFinder::Request do
  include EbayFinderHelper
    
  describe 'a new Request instance' do
    it 'should have US as default website' do
      EbayFinder::Request.new.website.should == 'US'
    end
    
    it 'should set app_id from ebay_config.yml file' do
      EbayFinder::Request.new.app_id.should == ebay_app_id_from_config
    end
    
    it 'should replace DE website with expected numeric value in query url' do
      url = EbayFinder::Request.new(:website => :DE).send(:query_url)
      url.should include('&siteid=77')
    end
  end
end
