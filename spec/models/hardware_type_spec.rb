require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HardwareType do
  describe 'a new blank instance' do
    it 'should not be valid' do
      HardwareType.new.should_not be_valid
    end
    
    it 'should require name' do
      HardwareType.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      hardware_type = Factory(:hardware_type)
      invalid = HardwareType.new(:name => hardware_type.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have hardware association' do
      HardwareType.new.hardware.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      HardwareType.new(:name => 'Portable').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      hardware_type = Factory(:hardware_type)
      hardware_type.id.should == hardware_type.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:hardware_type)}
    end
    
    it 'should sort hardware types by name' do
      HardwareType.ordered.should == HardwareType.all.sort_by(&:name)
    end
  end
end
