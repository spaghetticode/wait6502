require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IoPort do
  describe 'a new blank instance' do
    it 'should not be valid' do
      IoPort.new.should_not be_valid
    end
    
    it 'should require a name' do
      IoPort.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name/connector combination' do
      port = Factory(:io_port)
      invalid = IoPort.new(:name => port.name, :connector => port.connector)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have hardware association' do
      IoPort.new.hardware.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:io_port).should be_valid
    end
    
    it 'should have a full_name' do
      Factory(:io_port).full_name.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort ports by name' do
      5.times {Factory(:io_port)}
      IoPort.ordered.should == IoPort.all.sort_by(&:name)
    end
  end
  
  describe 'ILIKE_STRING' do
    it 'should include ILIKE ? string' do
      IoPort.ilike_string.should include('ILIKE ?')
    end
    
    it 'should include a COALESCE function for each search field' do
      IoPort::SEARCH_FIELDS.values.each do |field|
        IoPort.ilike_string.should include("COALESCE(#{field}, '')")
      end
    end
    
    it 'should join COALESCE functions with || ' do
      IoPort.ilike_string.should include(' || ')
    end
  end
end
