require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  describe 'a new blank instance' do
    before :all do
      @class = Country
    end
    
    include NaturalKeyTable 
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Country.new(:name => 'Italy').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      country = Factory(:country)
      country.id.should == country.name
    end
    
    it 'should have manufacturers association' do
      Country.new.manufacturers.should == []
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
