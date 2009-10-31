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
    
    it 'should have an original_prices association' do
      Peripheral.new.original_prices.should_not be_nil
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
  
  describe 'testing many-to-many associations' do
    describe 'an instance with associated CPUs' do
      before do
        peripheral.cpus << Factory(:cpu)
      end
    
      it 'should respondo to :cpu_names' do
        peripheral.should respond_to(:cpu_names)
      end
    
      it 'cpu_names should return a string with cpu names' do
        peripheral.cpus.each do |cpu|
          peripheral.cpu_names.should =~ %r{#{cpu.cpu_name_id}}
        end
      end
    end
        
    describe 'an instance with associated IO_PORTS' do
      before do
        peripheral.io_ports << Factory(:io_port)
      end
    
      it 'should respond to :io_port_names' do
        peripheral.should respond_to(:io_port_names)
      end
    
      it 'co_cpu_names should return a string with io port names' do
        peripheral.io_ports.each do |io_port|
          peripheral.io_port_names.should =~ /#{io_port.name}/
        end
      end
    end
    
    describe 'an instance with associated BUILTIN_STORAGES' do
      before do
        peripheral.builtin_storages << Factory(:builtin_storage)
      end
    
      it 'should respond to :storage_names' do
        peripheral.should respond_to(:storage_names)
      end
    
      it 'co_cpu_names should return a string with builtin storage names' do
        peripheral.builtin_storages.each do |storage|
          peripheral.storage_names.should =~ /#{storage.full_name}/
        end
      end
    end
  end
end
