require 'spec_helper'

describe CpuFamily do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CpuFamily.new.should_not be_valid
    end
    
    it 'should require name' do
      CpuFamily.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      cpu_family = Factory(:cpu_family)
      invalid = CpuFamily.new(:name => cpu_family.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      CpuFamily.new(:name => 'X86').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      cpu_family = Factory(:cpu_family)
      cpu_family.id.should == cpu_family.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:cpu_family)}
    end
    
    it 'should sort cpu families by name' do
      CpuFamily.ordered.should == CpuFamily.all.sort_by(&:name)
    end
  end
end
