require 'spec_helper'

describe "/hardware_types/index" do
  before(:each) do
    assigns[:hardware_types] = [
      stub_model(HardwareType, :name => 'computer')
    ]
    render 'hardware_types/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('h2')
    response.should have_tag('a', 'computer')
  end
end
