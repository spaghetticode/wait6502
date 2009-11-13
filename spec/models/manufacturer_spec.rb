require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Manufacturer do
  describe 'a new blank instance' do
    include NameUniqueRequired
    
    before :all do
      @class = Manufacturer
    end
        
    it 'should have hardware association' do
      @class.new.hardware.should_not be_nil
    end
    
    it 'should have cpus association' do
      @class.new.cpus.should_not be_nil
    end
    
    it 'should have co_cpus association' do
      @class.new.co_cpus.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:manufacturer).should be_valid
    end
    
    it 'should have an associated country' do
      Factory(:manufacturer).country.should be_a(Country)
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:manufacturer)}
    end
    
    it 'should sort manufacturers by name' do
      Manufacturer.ordered.should == Manufacturer.all.sort_by(&:name)
    end
  end
end
