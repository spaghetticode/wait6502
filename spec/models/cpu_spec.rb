require 'spec_helper'

module CpuHelper
  def valid_cpu(options={})
    @cpu ||= Factory(:cpu, options)
  end
end

describe Cpu do
  include CpuHelper
  
  describe 'an new blank instance' do
    before do
      @cpu = Cpu.new
    end
    
    it 'should not be valid' do
      @cpu.should_not be_valid
    end
    
    it 'should require a cpu_name' do
      @cpu.should have(1).error_on(:cpu_name)
    end
    
    it 'should require a cpu_bit' do
      @cpu.should have(1).error_on(:cpu_bit)
    end
    
    it 'should require a manufacturer' do
      @cpu.should have(1).error_on(:manufacturer)
    end
    
    it 'should have a hardware association' do
      @cpu.hardware.should_not be_nil
    end
    
    it 'should have no parent cpu' do
      @cpu.parent_cpu.should be_nil
    end
    
    it 'should have children cpus association' do
      @cpu.children_cpus.should be_empty
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      valid_cpu.should be_valid
    end
    
    it 'should have a full_name' do
      valid_cpu.full_name.should_not be_nil
    end
    
    it 'should require a unique cpu_name for given manufacturer and clock' do      
      Cpu.new(
        :cpu_name => valid_cpu.cpu_name,
        :clock => valid_cpu.clock,
        :manufacturer => valid_cpu.manufacturer
      ).should have(1).error_on(:cpu_name_id)
    end
    
    it 'should have expected parent_cpu' do
      parent = Factory(:cpu)
      cpu = valid_cpu(:parent_cpu => parent)
      cpu.parent_cpu.should == parent
    end
    
    it 'should have expected children_cpus' do
      parent = Factory(:cpu)
      child = Factory(:cpu, :parent_cpu => parent)
      parent.children_cpus.should include(child)
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort cpus by manufacturer' do
      5.times {Factory(:cpu)}
      Cpu.ordered.should == Cpu.all(:include => :manufacturer).sort_by{|cpu| cpu.manufacturer.name}
    end
  end
  
  describe 'MAIN named scope' do
    it 'should select CPUs without associated parent_cpu' do
      expected = Factory(:cpu, :parent_cpu => nil)
      Cpu.main.should include(expected)
    end
    
    it 'should reject CPUs with associated parent_cpu' do
      main = Factory(:cpu)
      rejected = Factory(:cpu, :clock => '', :parent_cpu => main)
      Cpu.main.should_not include(rejected)
    end
  end
  
  describe 'ILIKE_STRING' do
    it 'should include ILIKE ? string' do
      Cpu.ilike_string.should include('ILIKE ?')
    end
    
    it 'should include a COALESCE function for each search field' do
      Cpu::SEARCH_FIELDS.values.each do |field|
        Cpu.ilike_string.should include("COALESCE(#{field}, '')")
      end
    end
    
    it 'should join COALESCE functions with || ' do
      Cpu.ilike_string.should include(' || ')
    end
  end
end
