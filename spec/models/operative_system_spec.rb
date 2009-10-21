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
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      OperativeSystem.new(:name => 'X86').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      operative_system = Factory(:operative_system)
      operative_system.id.should == operative_system.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:operative_system)}
    end
    
    it 'should sort countries by name' do
      OperativeSystem.ordered.should == OperativeSystem.all.sort_by(&:name)
    end
  end
end
