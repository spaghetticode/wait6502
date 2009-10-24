require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ComputerType do
  describe 'a new blank instance' do
    it 'should not be valid' do
      ComputerType.new.should_not be_valid
    end
    
    it 'should require name' do
      ComputerType.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      computer_type = Factory(:computer_type)
      invalid = ComputerType.new(:name => computer_type.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have computers association' do
      ComputerType.new.computers.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      ComputerType.new(:name => 'Portable').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      computer_type = Factory(:computer_type)
      computer_type.id.should == computer_type.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:computer_type)}
    end
    
    it 'should sort computer types by name' do
      ComputerType.ordered.should == ComputerType.all.sort_by(&:name)
    end
  end
end
