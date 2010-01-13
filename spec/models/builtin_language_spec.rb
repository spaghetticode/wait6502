require 'spec_helper'

describe BuiltinLanguage do
  describe 'a new blank instance' do
    include NameUniqueRequired
    
    before :all do
      @class = StorageFormat
    end
    
    it 'should have hardware association' do
      BuiltinLanguage.new.hardware.should_not be_nil
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
    
    it 'should have a permalink' do
      Factory(:builtin_language).permalink.should_not be_nil
    end
    
    it 'should set permalink correctly when saving' do
      language = BuiltinLanguage.create!(:name => 'BASIC 2.0')
      language.permalink.should == 'basic-2-0'
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
