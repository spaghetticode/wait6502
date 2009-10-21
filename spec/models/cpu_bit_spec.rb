require 'spec_helper'

describe CpuBit do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CpuBit.new.should_not be_valid
    end
    
    it 'should require name' do
      CpuBit.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      cpu_bit = Factory(:cpu_bit)
      invalid = CpuBit.new(:name => cpu_bit.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      CpuBit.new(:name => '8/16 bit').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      cpu_family = Factory(:cpu_family)
      cpu_family.id.should == cpu_family.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:cpu_bit)}
    end
    
    it 'should sort countries by name' do
      CpuBit.ordered.should == CpuBit.all.sort_by(&:name)
    end
  end
end
