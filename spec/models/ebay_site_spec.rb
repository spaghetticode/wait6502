require 'spec_helper'

describe EbaySite do
  context 'a new blank instance' do
    it 'should not be valid' do
      EbaySite.new.should_not be_valid
    end
    
    it 'should require a name' do
      EbaySite.new.should have(1).error_on(:name)
    end
    
    it 'name should be unique' do
      valid = Factory(:ebay_site)
      EbaySite.new(:name => valid.name).should have(1).error_on(:name)
    end
  end
end
  