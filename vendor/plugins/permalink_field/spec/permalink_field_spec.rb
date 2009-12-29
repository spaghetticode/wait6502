require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

class TestClass < ActiveRecord::Base; end


describe String do
  describe 'gsub_accented_vowels' do
    it 'should replace accented vowels' do
      'àèìòù'.gsub_accented_vowels.should == 'aeiou'
    end
    
    it 'should return original string' do
      'foo'.gsub_accented_vowels.should == 'foo'
    end
  end
  
  describe 'gsub_ampersand' do
    it 'should replace ampersand when present' do
      '&'.gsub_ampersand.should == 'and'
    end
    
    it 'should return original string' do
      'foo'.gsub_ampersand.should == 'foo'
    end
  end
  
  describe 'gsub_invalid_chars' do
    it 'should replace invalid charactes' do
      '£3 is worth nothing...'.gsub_invalid_chars.should == '3-is-worth-nothing'
    end
  end
  
  describe 'permalink' do
    it 'should return expected string' do
      'lùnch-for 3£/persons'.permalink.should == 'lunch-for-3-persons'
    end
  end
end

describe PermalinkField do
  TestClass.class_eval do
    permalink_field(:name)
  end
end