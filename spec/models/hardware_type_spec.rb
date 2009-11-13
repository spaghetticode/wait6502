require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HardwareType do
  include NaturalKeyTable 

  before :all do
    @class = HardwareType
  end  
    
  it 'should have hardware association' do
    HardwareType.new.hardware.should_not be_nil
  end
end
