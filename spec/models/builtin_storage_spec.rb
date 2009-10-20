require 'spec_helper'

module BuiltinStorageHelpers
  def builtin_storage
    @bs ||= Factory(:builtin_storage)
  end
end

describe BuiltinStorage do
  include BuiltinStorageHelpers
  
  describe 'a new blank instance' do
    it 'should not be valid' do
      BuiltinStorage.new.should_not be_valid
    end
    
    it 'should require a storage_name_id' do
      BuiltinStorage.new.should have(1).error_on(:storage_name_id)
    end
    
    it 'should have unique storage name for given storage format and size' do
      invalid = BuiltinStorage.new(
        :storage_name_id => builtin_storage.storage_name_id,
        :storage_format_id => builtin_storage.storage_format_id,
        :storage_size_id => builtin_storage.storage_size_id
      )
      invalid.should have(1).error_on(:storage_name_id)
    end
  end
  
  describe 'an instance with valid attributes' do
    
    it 'should be valid' do
      builtin_storage.should be_valid
    end
    
    it 'should have associated storage name' do
      builtin_storage.storage_name.should_not be_nil
    end
    
    it 'should have associated storage format' do
      builtin_storage.storage_format.should_not be_nil
    end
    
    it 'should have associated storage size' do
      builtin_storage.storage_size.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    before do 
      5.times {Factory(:builtin_storage)}
    end
    
    it 'should sort builtin storages by storage_name_id' do
      BuiltinStorage.ordered.should == BuiltinStorage.all.sort_by(&:storage_name_id)
    end
  end
end
