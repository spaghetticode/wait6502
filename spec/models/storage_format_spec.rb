require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageFormat do
  describe 'a new blank instance' do
    include NameUniqueRequired

    before :all do
      @class = StorageFormat
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
