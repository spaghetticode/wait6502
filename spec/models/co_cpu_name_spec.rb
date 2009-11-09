require 'spec_helper'

describe CoCpuName do
  describe 'a new blank instance' do
    it 'should not be valid' do
      CoCpuName.new.should_not be_valid
    end
    
    it 'should require name' do
      CoCpuName.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      co_cpu_name = Factory(:co_cpu_name)
      invalid = CoCpuName.new(:name => co_cpu_name.name)
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      CoCpuName.new(:name => 'Agnus').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      co_cpu_name = Factory(:co_cpu_name)
      co_cpu_name.id.should == co_cpu_name.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:co_cpu_name)}
    end
    
    it 'should sort co cpu names by name' do
      CoCpuName.ordered.should == CoCpuName.all.sort_by(&:name)
    end
  end
end
