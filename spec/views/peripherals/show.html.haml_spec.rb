require 'spec_helper'

describe "/peripherals/show" do
  before(:each) do
    manufacturer = mock_model(Manufacturer, :name => 'Apple', :logo => nil)
    assigns[:peripheral] = mock_model(Hardware, :manufacturer => manufacturer, :name => 'Apple IIc').as_null_object
    render 'peripherals/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
