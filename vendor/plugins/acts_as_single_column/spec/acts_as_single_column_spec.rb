require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

# TODO should be tested more thoroughly
describe ActsAsSingleColumn do
  class TestModel < ActiveRecord::Base
    include ActsAsSingleColumn
  end
  
  it 'should receive expected method calls' do
    TestModel.should_receive(:validates_presence_of).with(:name)
    TestModel.should_receive(:validates_uniqueness_of).with(:name, {:case_sensitive=>false})
    TestModel.send(:acts_as_single_column, :name)
  end
  
  describe 'an active record model using the plugin' do
    before do
      TestModel.acts_as_single_column :name
    end
    
    it 'should have "name" as primary key' do
      TestModel.primary_key.should == 'name'
    end
    
    it 'should have a "ordered" class method' do
      TestModel.should respond_to(:ordered)
    end
  end
end