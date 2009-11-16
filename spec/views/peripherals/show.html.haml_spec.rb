require 'spec_helper'

describe "/peripherals/show" do
  before(:each) do
    assigns[:peripheral] = mock_model(Hardware).as_null_object
    render 'peripherals/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
