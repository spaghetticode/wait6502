require 'spec_helper'

describe CpuName do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CpuName.new.should_not be_valid
    end
    
    it 'should require name' do
      CpuName.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      cpu_name = Factory(:cpu_name)
      invalid = CpuName.new(:name => cpu_name.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      CpuName.new(:name => 'X86').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      cpu_name = Factory(:cpu_name)
      cpu_name.id.should == cpu_name.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:cpu_name)}
    end
    
    it 'should sort countries by name' do
      CpuName.ordered.should == CpuName.all.sort_by(&:name)
    end
  end
end

