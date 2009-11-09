require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageFormat do
  describe 'a new blank instance' do
    it 'should not be valid' do
      StorageFormat.new.should_not be_valid
    end
    
    it 'should require name' do
      StorageFormat.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      storage_format = Factory(:storage_format)
      invalid = StorageFormat.new(:name => storage_format.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      StorageFormat.new(:name => '3.5 inches').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      storage_format = Factory(:storage_format)
      storage_format.id.should == storage_format.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:storage_format)}
    end
    
    it 'should sort storage formats by name' do
      StorageFormat.ordered.should == StorageFormat.all.sort_by(&:name)
    end
  end
end
