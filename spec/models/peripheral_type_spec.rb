require 'spec_helper'

describe PeripheralType do
  
  def per_type
    @pt ||= Factory(:peripheral_type)
  end
  
  describe 'a new blank instance' do
    it 'should not be valid' do
      PeripheralType.new.should_not be_valid
    end
    
    it 'should require a name' do
      PeripheralType.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      invalid = PeripheralType.new(:name => per_type.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have peripherals association' do
      PeripheralType.new.peripherals.should == []
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      per_type.should be_valid
    end
    
    it 'should have name same as id(name is primary key)' do
      per_type.id.should == per_type.name
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort peripheral types by name' do
      5.times { Factory(:peripheral_type)}
      PeripheralType.ordered.should == PeripheralType.all.sort_by(&:name)
    end
  end
end