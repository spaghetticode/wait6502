require 'spec_helper'

describe Computer do
  describe 'a new blank instance' do
    it 'should require a name' do
      Computer.new.should have(1).error_on(:name)
    end
    
    it 'should require a manufacturer' do
      Computer.new.should have(1).error_on(:manufacturer)
    end
    
    it 'should require a computer type' do
      Computer.new.should have(1).error_on(:computer_type)
    end
  end
  
  describe 'an instance with valid attributes' do
    def valid_computer
      @valid = Factory(:computer)
    end
    
    it 'should be valid' do
      valid_computer.should be_valid
    end
    
    it 'should have a manufacturer association' do
      valid_computer.manufacturer.should_not be_nil
    end
    
    it 'should have a computer type association' do
      valid_computer.computer_type.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort computer by manufacturers and name' do
      5.times{Factory(:computer)}
      Computer.ordered.should == Computer.all.sort_by{|c| [c.manufacturer.name, c.name]}
    end
  end
end
