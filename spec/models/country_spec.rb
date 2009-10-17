require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  describe 'a new blank instance' do
    it 'should not be valid' do
      Country.new.should_not be_valid
    end
    
    it 'should require name' do
      Country.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      country = Factory(:country)
      invalid = Country.new(:name => country.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Country.new(:name => 'Italy').should be_valid
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:country)}
    end
    
    it 'should sort countries by name' do
      Country.ordered.should == Country.all.sort_by(&:name)
    end
  end
end
