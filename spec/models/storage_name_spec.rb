require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageName do
  describe 'a new blank instance' do
    it 'should not be valid' do
      StorageName.new.should_not be_valid
    end
    
    it 'should require name' do
      StorageName.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      storage_name = Factory(:storage_name)
      invalid = StorageName.new(:name => storage_name.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    def storage_name
      @storage ||= Factory(:storage_name)
    end
    
    it 'should be valid' do
      storage_name.should be_valid
    end
    
    it 'should have name same as id' do
      storage_name.id.should == storage_name.name
    end
  end
  
  describe 'ORDERED named scope' do
    before do
      5.times {Factory(:storage_name)}
    end
    
    it 'should sort storage names by name' do
      StorageName.ordered.should == StorageName.all.sort_by(&:name)
    end
  end
end
