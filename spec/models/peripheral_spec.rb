require 'spec_helper'

describe Peripheral do
  def peripheral
    @peripheral ||= Factory(:peripheral)
  end
    
  describe 'a new blank instance' do
    it 'should not be valid' do
      Peripheral.new.should_not be_valid
    end
    
    it 'should require a manufacturer' do
      Peripheral.new.should have(1).error_on(:manufacturer)
    end
    
    it 'should require a peripheral_type' do
      Peripheral.new.should have(1).error_on(:peripheral_type)
    end
    
    it 'should require a name' do
      Peripheral.new.should have(1).error_on(:name)
    end
    
    it 'should have io ports association' do
      Peripheral.new.io_ports.should_not be_nil
    end
    
    it 'should have a cpus association' do
      Peripheral.new.cpus.should_not be_nil
    end
    
    it 'should have a builtin_storages association' do
      Peripheral.new.builtin_storages.should_not be_nil
    end 
    
    it 'should require a unique name for given manufacturer and code' do
      invalid = Peripheral.new(
        :name => peripheral.name,
        :code => peripheral.code,
        :manufacturer => peripheral.manufacturer
      )
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      peripheral.should be_valid
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort peripherals by name' do
      5.times {Factory(:peripheral)}
      Peripheral.ordered.should == Peripheral.all.sort_by(&:name)
    end
  end
end
