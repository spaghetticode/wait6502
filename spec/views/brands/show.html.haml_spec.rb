require 'spec_helper'

describe "/brands/show" do
  before(:each) do
    assigns[:brand] = mock_model(Manufacturer).as_null_object
    render 'brands/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
