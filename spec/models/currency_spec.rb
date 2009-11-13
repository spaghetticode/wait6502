require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Currency do
  include NaturalKeyTable 

  before :all do
    @class = Currency
  end
end 
