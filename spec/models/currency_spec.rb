require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Currency do
  include NaturalKeyTable 

  before :all do
    @class = Currency
  end
  
  describe 'a blank empty currency' do
    before do
      @currency = Currency.new
    end
    
    it 'should have auctions association' do
      @currency.auctions.should_not be_nil
    end
    
    it 'should have a ebay sites association' do
      @currency.ebay_sites.should_not be_nil
    end
    
    it 'should have a original prices association' do
      @currency.original_prices.should_not be_nil
    end
    
    it 'should be unused' do
      @currency.should be_unused
    end
  end
  
  describe 'a valid currency' do
    describe 'when has associated price, ebay site or auction' do
      it 'should not be unused' do
        currency = Factory(:currency)
        [:original_prices, :auctions, :ebay_sites].each do |association|
          klass = association.to_s.singularize.camelize.constantize
          currency.stub!(association => [mock_model(klass)])
          currency.should_not be_unused
        end
      end
    end
  end
end 
