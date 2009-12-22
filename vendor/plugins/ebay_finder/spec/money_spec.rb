require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

describe EbayFinder::Money do
  describe 'a money instance' do
    before do
      @currency_hash = {'currencyID' => 'USD', 'content' => '10.99'}
      @money = EbayFinder::Money.new(@currency_hash)
    end

    it 'should have expected expected amount' do
      @money.amount.should  == @currency_hash['content'].to_f
    end
    
    it 'should have expected currency_id' do
      @money.currency_id.should == @currency_hash['currencyID']
    end
    
    it 'should have expected string format' do
      @money.to_s.should == 'USD 10.99'
    end
  end
end