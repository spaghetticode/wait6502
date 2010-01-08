require 'spec_helper'

describe Hardware do
  describe 'a new blank instance' do
    it 'should require a name' do
      Hardware.new.should have(1).error_on(:name)
    end
  
    it 'should require a manufacturer' do
      Hardware.new.should have(1).error_on(:manufacturer)
    end
  
    it 'should require a hardware type' do
      Hardware.new.should have(1).error_on(:hardware_type)
    end
  
    it 'should require a hardware_category' do
      Hardware.new.should have(1).error_on(:hardware_category)
    end
   
    it 'should have cpus association' do
      Hardware.new.cpus.should_not be_nil
    end
  
    it 'should have builtin_storages association' do
      Hardware.new.builtin_storages.should_not be_nil
    end
  
    it 'should have operative_systems association' do
      Hardware.new.operative_systems.should_not be_nil
    end
  
    it 'should have co_cpus association' do
      Hardware.new.co_cpus.should_not be_nil
    end
  
    it 'should have io_ports association' do
      Hardware.new.io_ports.should_not be_nil
    end
  
    it 'should have an original_prices association' do
      Hardware.new.original_prices.should_not be_nil
    end
  
    it 'should have an images association' do
      Hardware.new.images.should_not be_nil
    end
    
    it 'should have an auctions association' do
      Hardware.new.auctions.should_not be_nil
    end
  
    it 'should require a unique name for given manufacturer and code' do
      code = '12345'
      valid = Factory(:hardware, :code => code)
      Hardware.new(
        :name => valid.name,
        :code => code,
        :manufacturer => valid.manufacturer
      ).should_not be_valid
    end
  end
  
  describe 'an instance with valid attributes' do
    def valid_hardware(options = {})
      @valid ||= Factory(:hardware, options)
    end

    it 'should be valid' do
      valid_hardware.should be_valid
    end

    it 'should have a manufacturer association' do
      valid_hardware.manufacturer.should_not be_nil
    end

    it 'should have a hardware type association' do
      valid_hardware.hardware_type.should_not be_nil
    end

    it 'should have a builtin_language association' do
      hardware = Factory(:hardware, :builtin_language => Factory(:builtin_language))
      hardware.builtin_language.should_not be_nil
    end
    
    it 'full name should include manufacturer name' do
      valid_hardware.full_name.should include(valid_hardware.manufacturer.name)
    end
    
    it 'full name should not include the manufacturer name twice' do
      manufacturer = mock_model(Manufacturer, :name => 'Atari')
      hardware = Hardware.new(:name => 'Atari 800', :manufacturer => manufacturer)
      hardware.full_name.should == 'Atari 800'
    end
  end

  describe 'ordered named scope' do
    it 'should sort hardware by manufacturers and name' do
      5.times{Factory(:hardware)}
      Hardware.ordered.should == Hardware.all.sort_by(&:name)
    end
  end

  describe 'computer and peripheral named scopes' do
    before do
      Hardware::CATEGORIES.each do |category|
        3.times{Factory(:hardware, :hardware_category => category)}
      end
    end
    
    it 'should select only computer hardware' do
      Hardware.computer.each do |hw|
        hw.hardware_category.should == 'computer'
      end
    end
    
    it 'should select only peripheral hardware' do
      Hardware.peripheral.each do |hw|
        hw.hardware_category.should == 'peripheral'
      end
    end
  end
  
  describe 'testing many-to-many associations' do
    describe 'an instance with associated CPUs' do
      before do
        @hardware = Factory(:hardware)
        @hardware.cpus << Factory(:cpu)
      end

      it 'should respondo to :cpu_names' do
        @hardware.should respond_to(:cpu_names)
      end

      it 'cpu_names should return a string with cpu names' do
        @hardware.cpus.each do |cpu|
          @hardware.cpu_names.should =~ %r{#{cpu.cpu_name_id}}
        end
      end
    end
    
    describe 'an instance with associated Co-CPUs' do
      before do
        @hardware = Factory(:hardware)
        @hardware.co_cpus << Factory(:co_cpu)
      end
    
      it 'should respond to :co_cpu_names' do
        @hardware.should respond_to(:co_cpu_names)
      end
    
      it 'co_cpu_names should return a string with co_cpu names' do
        @hardware.co_cpus.each do |co_cpu|
          @hardware.co_cpu_names.should =~ /#{co_cpu.co_cpu_name_id}/
        end
      end
    end
    
    describe 'an instance with associated IO_PORTS' do
      before do
        @hardware = Factory(:hardware)
        @hardware.io_ports << Factory(:io_port)
      end
    
      it 'should respond to :io_port_names' do
        @hardware.should respond_to(:io_port_names)
      end
    
      it 'co_cpu_names should return a string with io port names' do
        @hardware.io_ports.each do |io_port|
          @hardware.io_port_names.should =~ /#{io_port.name}/
        end
      end
    end
    
    describe 'an instance with associated BUILTIN_STORAGES' do
      before do
        @hardware = Factory(:hardware)
        @hardware.builtin_storages << Factory(:builtin_storage)
      end
    
      it 'should respond to :storage_names' do
        @hardware.should respond_to(:storage_names)
      end
    
      it 'co_cpu_names should return a string with builtin storage names' do
        @hardware.builtin_storages.each do |storage|
          @hardware.storage_names.should =~ /#{storage.full_name}/
        end
      end
    end
    
    describe 'an instance with associated OPERATIVE_SYSTEMS' do
        before do
          @hardware = Factory(:hardware)
          @hardware.operative_systems << Factory(:operative_system)
        end

        it 'should respond to :os_names' do
          @hardware.should respond_to(:os_names)
        end

        it 'co_cpu_names should return a string with operative systems names' do
          @hardware.operative_systems.each do |os|
            @hardware.os_names.should =~ /#{os.name}/
          end
        end
      end  
  end
  
  describe 'filter_initial named scope' do
    it 'should return hardware with names starting with given letter' do
      expected_results = (1..2).map{|n| Factory(:hardware, :name => "Apple #{n}")}
      Hardware.filter_initial('a').should == expected_results
    end
    
    it 'should reject hardware with names not starting with given letter' do
      expected_rejected = (1..2).map{|n| Factory(:hardware, :name => "Orange #{n}")}
      expected_rejected.each do |rejected|
        Hardware.filter_initial('a').should_not include(rejected)
      end
    end      
  end
  
  describe 'self.CONDITIONS' do
    it 'should include ILIKE ? string when params[:keywords] is passed' do
      Hardware.conditions(:keywords => 'amiga').first.should include('ILIKE ?')
    end
  end
  
  describe 'self.SEARCH_FIELD_STRING' do
    it 'should include a COALESCE function for each search field' do
      Hardware::SEARCH_FIELDS.values.each do |field|
        Hardware.search_field_string.should include("COALESCE(#{field}, '')")
      end
    end
    
    it 'should join COALESCE functions with || ' do
      Hardware.search_field_string.should include(' || ')
    end
  end
  
  describe 'self.to_select' do
    it 'should return an array' do
      Hardware.to_select.should be_an(Array)
    end
    
    it 'should map name and id' do
      hardware = Factory(:hardware)
      name, id = hardware.name, hardware.id
      Hardware.to_select.should include([name, id])
    end
  end
end