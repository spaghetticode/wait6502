require 'spec_helper'

describe "/computers/show" do
  before(:each) do
    manufacturer = mock_model(Manufacturer, :name => 'Apple', :full_name => 'Apple').as_null_object
    assigns[:computer] = mock_model(Hardware, :full_name => 'Apple IIc', :images => [], :manufacturer => manufacturer).as_null_object
    render 'computers/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
