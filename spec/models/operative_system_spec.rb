require 'spec_helper'

describe OperativeSystem do
  describe 'a new blank instance' do
    it 'should not be valid' do
      OperativeSystem.new.should_not be_valid
    end
    
    it 'should require name' do
      OperativeSystem.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      operative_system = Factory(:operative_system)
      invalid = OperativeSystem.new(:name => operative_system.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have a hardware association' do
      OperativeSystem.new.hardware.should_not be_nil
    end
    
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:operative_system).should be_valid
    end
    
    it 'should have a full name' do
      Factory(:operative_system).full_name.should_not be_nil
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:operative_system)}
    end
    
    it 'should sort operative systems by name' do
      OperativeSystem.ordered.should == OperativeSystem.all.sort_by(&:name)
    end
  end
end
