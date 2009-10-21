require 'spec_helper'

module CpuHelper
  def valid_cpu
    @cpu ||= Factory(:cpu)
  end
end

describe Cpu do
  include CpuHelper
  
  describe 'an new blank instance' do
    
    it 'should not be valid' do
      Cpu.new.should_not be_valid
    end
    
    it 'should require a cpu_name' do
      Cpu.new.should have(1).error_on(:cpu_name)
    end
    
    it 'should require a cpu_bit' do
      Cpu.new.should have(1).error_on(:cpu_bit)
    end
    
    it 'should require a manufacturer' do
      Cpu.new.should have(1).error_on(:manufacturer)
    end
    
    it 'should require a unique cpu_name for given manufacturer and clock' do      
      Cpu.new(
        :cpu_name => valid_cpu.cpu_name,
        :clock => valid_cpu.clock,
        :manufacturer => valid_cpu.manufacturer
      ).should have(1).error_on(:cpu_name_id)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      valid_cpu.should be_valid
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort cpus by manufacturer' do
      5.times {Factory(:cpu)}
      Cpu.ordered.should == Cpu.all(:include => :manufacturer).sort_by{|cpu| cpu.manufacturer.name}
    end
  end
end
