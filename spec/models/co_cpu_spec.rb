require 'spec_helper'

describe CoCpu do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CoCpu.new.should_not be_valid
    end
    
    it 'should require a co_cpu_name' do
      CoCpu.new.should have(1).error_on(:co_cpu_name)
    end
    
    it 'should require a manufacturer' do
      CoCpu.new.should have(1).error_on(:manufacturer)
    end
    
    it 'should require a co_cpu_type' do
      CoCpu.new.should have(1).error_on(:co_cpu_type)
    end
    
    it 'could have a co_cpu_family' do
      co_cpu = CoCpu.new(:cpu_family => Factory(:cpu_family))
      co_cpu.cpu_family.should_not be_nil
    end      
    
    it 'should require a unique co_cpu_name for given manufacturer' do
      co_cpu = Factory(:co_cpu)
      invalid = CoCpu.new(:co_cpu_name => co_cpu.co_cpu_name, :manufacturer => co_cpu.manufacturer)
      invalid.should have(1).error_on(:co_cpu_name_id)
    end
    
    it 'should have hardware association' do
      CoCpu.new.hardware.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      Factory(:co_cpu).should be_valid
    end
    
    it 'should have a full_name' do
      Factory(:co_cpu).full_name.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort co cpus by co_cpu_name_id' do
      5.times {Factory(:co_cpu)}
      CoCpu.ordered.should == CoCpu.all.sort_by(&:co_cpu_name_id)
    end
  end
  
  describe 'ILIKE_STRING' do
    it 'should include ILIKE ? string' do
      CoCpu.ilike_string.should include('ILIKE ?')
    end
    
    it 'should include a COALESCE function for each search field' do
      CoCpu::SEARCH_FIELDS.values.each do |field|
        CoCpu.ilike_string.should include("COALESCE(#{field}, '')")
      end
    end
    
    it 'should join COALESCE functions with || ' do
      CoCpu.ilike_string.should include(' || ')
    end
  end
end
