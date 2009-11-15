require 'spec_helper'

describe EbaySite do
  include NaturalKeyTable 

  before :all do
    @class = EbaySite
  end
  
  it 'should require a currency' do
    @class.new.should have(1).error_on(:currency)
  end
  
  it 'should require an image' do
    @class.new.should have(1).error_on(:image)
  end
end
  