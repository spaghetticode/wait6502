require 'spec_helper'

describe ManufacturersController do

  #Delete these examples and add some real ones
  it "should use ManufacturersController" do
    controller.should be_an_instance_of(ManufacturersController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful when param matches mock_manufacturer.to_param" do
      mock_manufacturer = mock_model(Manufacturer, :name => 'Apple')
      Manufacturer.should_receive(:find).and_return(mock_manufacturer)
      get 'show', :id => mock_manufacturer.to_param
      response.should be_success
    end
    
    it 'should redirect when param doesnt match mock_manufacturer.to_param' do
      mock_manufacturer = mock_model(Manufacturer, :name => 'Apple')
      Manufacturer.should_receive(:find).and_return(mock_manufacturer)
      get 'show', :id => mock_manufacturer.to_param + 'foo'
      response.should redirect_to(manufacturer_path(mock_manufacturer))
    end
  end
end
