require 'spec_helper'

describe OriginalPrice do
  describe 'a blank new instance' do
    it 'should not be valid' do
      OriginalPrice.new.should_not be_valid
    end
    
    it 'should require a currency' do
      OriginalPrice.new.should have(1).error_on(:currency)
    end
    
    it 'should require a country' do
      OriginalPrice.new.should have(1).error_on(:country)
    end
    
    it 'should require a date' do
      OriginalPrice.new.should have(1).error_on(:date)
    end
    
    it 'should require an amount' do
      OriginalPrice.new.should have_at_least(1).error_on(:amount)
    end
    
    it 'should require a purchaseable_id' do
      OriginalPrice.new.should have(1).error_on(:purchaseable_id)
    end
    
    it 'should require a purchaseable_type' do
      OriginalPrice.new.should have(1).error_on(:purchaseable_type)
    end
    
    it 'should not be tainted' do
      OriginalPrice.new.should_not be_tainted
    end
    
    it 'amount should be a number' do
      OriginalPrice.new(:amount => 'string').should have(1).error_on(:amount)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:original_price).should be_valid
    end
    
    it 'should have a purchaseable associated object' do
      Factory(:original_price).purchaseable.should_not be_nil
    end
    
    it 'can be tainted' do
      Factory(:original_price, :tainted => true).should be_tainted
    end
  end
  
  describe 'named scope tainted' do
    before do
      3.times{Factory(:original_price)}
      OriginalPrice.last.update_attribute(:tainted, true)
    end
    
    it 'should select tainted original prices' do
      OriginalPrice.tainted.each do |price|
        price.should be_tainted
      end
    end
    
    it 'should find only one original price' do
      OriginalPrice.tainted.should have(1).price
    end
  end
  
  describe 'named scope untainted' do
    before do
      3.times{Factory(:original_price)}
      OriginalPrice.last.update_attribute(:tainted, true)
    end
    
    it 'should select untainted original prices' do
      OriginalPrice.untainted.each do |price|
        price.should_not be_tainted
      end
    end
    
    it 'should select 2 original prices' do
      OriginalPrice.untainted.should have(2).prices
    end
  end
end