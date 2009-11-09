require 'spec_helper'

describe StorageSize do
  describe 'a new blank instance' do
    it 'should not be valid' do
      StorageSize.new.should_not be_valid
    end
    
    it 'should require name' do
      StorageSize.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      storage_size = Factory(:storage_size)
      invalid = StorageSize.new(:name => storage_size.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      StorageSize.new(:name => '3.5 inches').should be_valid
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
    
    it 'should sort storage sizes by name' do
      StorageSize.ordered.should == StorageSize.all.sort_by(&:name)
    end
  end
end
