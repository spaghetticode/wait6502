require 'spec_helper'

describe CoCpuType do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CoCpuType.new.should_not be_valid
    end
    
    it 'should require name' do
      CoCpuType.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      co_cpu_type = Factory(:co_cpu_type)
      invalid = CoCpuType.new(:name => co_cpu_type.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      CoCpuType.new(:name => 'X86').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      co_cpu_type = Factory(:co_cpu_type)
      co_cpu_type.id.should == co_cpu_type.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:co_cpu_type)}
    end
    
    it 'should sort co cpu types by name' do
      CoCpuType.ordered.should == CoCpuType.all.sort_by(&:name)
    end
  end
end
