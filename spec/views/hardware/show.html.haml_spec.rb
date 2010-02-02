require 'spec_helper'

describe "/hardware/show" do
  before(:each) do
    manufacturer = mock_model(Manufacturer, :name => 'Apple', :full_name => 'Apple').as_null_object
    assigns[:hardware] = mock_model(Hardware, :full_name => 'Apple IIc', :images => [], :manufacturer => manufacturer).as_null_object
    render 'hardware/show'
  end

  it "should render" do
    response.should be_true
  end
end
