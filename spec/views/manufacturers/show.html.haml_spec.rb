require 'spec_helper'

describe "/manufacturers/show" do
  before(:each) do
    assigns[:manufacturer] = mock_model(Manufacturer).as_null_object
    render 'manufacturers/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
