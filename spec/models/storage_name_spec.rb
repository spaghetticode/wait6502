require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageName do
  include NaturalKeyTable 

  before :all do
    @class = StorageName
  end
end
