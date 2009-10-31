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
      OriginalPrice.new.should have(1).error_on(:amount)
    end
    
    it 'should require a purchaseable_id' do
      OriginalPrice.new.should have(1).error_on(:purchaseable_id)
    end
    
    it 'should require a purchaseable_type' do
      OriginalPrice.new.should have(1).error_on(:purchaseable_type)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:original_price).should be_valid
    end
    
    it 'should have a purchaseable associated object' do
      Factory(:original_price).purchaseable.should_not be_nil
    end
  end
end