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
end
