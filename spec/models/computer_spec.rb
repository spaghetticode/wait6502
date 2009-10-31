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
    
    it 'should have cpus association' do
      Computer.new.cpus.should_not be_nil
    end
    
    it 'should have builtin_storages association' do
      Computer.new.builtin_storages.should_not be_nil
    end
    
    it 'should have operative_systems association' do
      Computer.new.operative_systems.should_not be_nil
    end
    
    it 'should have co_cpus association' do
      Computer.new.co_cpus.should_not be_nil
    end
    
    it 'should have io_ports association' do
      Computer.new.io_ports.should_not be_nil
    end
    
    it 'should have an original_prices association' do
      Computer.new.original_prices.should_not be_nil
    end
    
    it 'should require a unique name for given manufacturer and code' do
      code = '12345'
      valid = Factory(:computer, :code => code)
      Computer.new(
        :name => valid.name,
        :code => code,
        :manufacturer => valid.manufacturer
      ).should_not be_valid
    end
  end
  
  describe 'an instance with valid attributes' do
    def valid_computer(options = {})
      @valid = Factory(:computer, options)
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
    
    it 'should have a builtin_language association' do
      computer = Factory(:computer, :builtin_language => Factory(:builtin_language))
      computer.builtin_language.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort computer by manufacturers and name' do
      5.times{Factory(:computer)}
      Computer.ordered.should == Computer.all.sort_by{|c| [c.manufacturer.name, c.name]}
    end
  end
  
  describe 'testing many-to-many associations' do
    describe 'an instance with associated CPUs' do
      before do
        @computer = Factory(:computer)
        @computer.cpus << Factory(:cpu)
      end
    
      it 'should respondo to :cpu_names' do
        @computer.should respond_to(:cpu_names)
      end
    
      it 'cpu_names should return a string with cpu names' do
        @computer.cpus.each do |cpu|
          @computer.cpu_names.should =~ %r{#{cpu.cpu_name_id}}
        end
      end
    
      describe 'an instance with associated Co-CPUs' do
        before do
          @computer = Factory(:computer)
          @computer.co_cpus << Factory(:co_cpu)
        end
      
        it 'should respond to :co_cpu_names' do
          @computer.should respond_to(:co_cpu_names)
        end
      
        it 'co_cpu_names should return a string with co_cpu names' do
          @computer.co_cpus.each do |co_cpu|
            @computer.co_cpu_names.should =~ /#{co_cpu.co_cpu_name_id}/
          end
        end
      end
    
      describe 'an instance with associated IO_PORTS' do
        before do
          @computer = Factory(:computer)
          @computer.io_ports << Factory(:io_port)
        end
      
        it 'should respond to :io_port_names' do
          @computer.should respond_to(:io_port_names)
        end
      
        it 'co_cpu_names should return a string with io port names' do
          @computer.io_ports.each do |io_port|
            @computer.io_port_names.should =~ /#{io_port.name}/
          end
        end
      end

      describe 'an instance with associated BUILTIN_STORAGES' do
        before do
          @computer = Factory(:computer)
          @computer.builtin_storages << Factory(:builtin_storage)
        end
      
        it 'should respond to :storage_names' do
          @computer.should respond_to(:storage_names)
        end
      
        it 'co_cpu_names should return a string with builtin storage names' do
          @computer.builtin_storages.each do |storage|
            @computer.storage_names.should =~ /#{storage.full_name}/
          end
        end
      end
  
      describe 'an instance with associated OPERATIVE_SYSTEMS' do
        before do
          @computer = Factory(:computer)
          @computer.operative_systems << Factory(:operative_system)
        end
      
        it 'should respond to :os_names' do
          @computer.should respond_to(:os_names)
        end
      
        it 'co_cpu_names should return a string with operative systems names' do
          @computer.operative_systems.each do |os|
            @computer.os_names.should =~ /#{os.name}/
          end
        end
      end  
    end
  end
end

