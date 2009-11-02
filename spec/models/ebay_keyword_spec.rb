require 'spec_helper'

describe EbayKeyword do
  def valid_keyword(options={})
    @valid ||= Factory(:ebay_keyword)
  end
  
  describe 'a new blank instance' do
    it 'should not be valid' do
      EbayKeyword.new.should_not be_valid
    end
    
    it 'should require a name' do
      EbayKeyword.new.should have(1).error_on(:name)
    end
    
    it 'should require a searchable' do
      EbayKeyword.new.should have(1).error_on(:searchable)
    end
    
    it 'should require a unique name for given searchable_id' do
      invalid = EbayKeyword.new(
        :name => valid_keyword.name,
        :searchable => valid_keyword.searchable
      )
      invalid.should have(1).error_on(:name)
    end
  end
  
  describe 'an instance with valid attributes' do
    it 'should be valid' do
      valid_keyword.should be_valid
    end
    
    it 'should have an associated searchable item' do
      valid_keyword.searchable.should_not be_nil
    end
  end
  
  describe 'ORDERED named scope' do
    it 'should sort keywords by name' do
      5.times {Factory(:ebay_keyword)}
      EbayKeyword.ordered.should == EbayKeyword.all.sort_by(&:name)
    end
  end
end 

