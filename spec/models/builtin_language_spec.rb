require 'spec_helper'

describe BuiltinLanguage do
  describe 'a new blank instance' do
    it 'should not be valid' do
      BuiltinLanguage.new.should_not be_valid
    end
    
    it 'should require name' do
      BuiltinLanguage.new.should have(1).error_on(:name)
    end
    
    it 'should require a unique name' do
      builtin_language = Factory(:builtin_language)
      invalid = BuiltinLanguage.new(:name => builtin_language.name)
      invalid.should have(1).error_on(:name)
    end
    
    it 'should have computers association' do
      BuiltinLanguage.new.computers.should_not be_nil
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      BuiltinLanguage.new(:name => 'X86').should be_valid
    end
    
    it 'should have id same as name (name is primary key)' do
      builtin_language = Factory(:builtin_language)
      builtin_language.id.should == builtin_language.name
    end
  end
  
  describe 'named scope ORDERED' do
    before do
      5.times {Factory(:builtin_language)}
    end
    
    it 'should sort countries by name' do
      BuiltinLanguage.ordered.should == BuiltinLanguage.all.sort_by(&:name)
    end
  end
end
