require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Currency do
  describe 'a new blank instance' do
    it 'should not be valid' do
      Currency.new.should_not be_valid
    end
    
    it 'should require name' do
      Currency.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      currency = Factory(:currency)
      invalid = Currency.new(:name => currency.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:currency).should be_valid
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:currency)}
    end
    
    it 'should sort currencies by name' do
      Currency.ordered.should == Currency.all.sort_by(&:name)
    end
  end
end 
