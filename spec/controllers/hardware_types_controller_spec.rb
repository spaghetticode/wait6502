require 'spec_helper'

describe HardwareTypesController do

  #Delete these examples and add some real ones
  it "should use HardwareTypesController" do
    controller.should be_an_instance_of(HardwareTypesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      mock_type = mock_model(HardwareType, :name => 'personal computer')
      HardwareType.should_receive(:find).and_return(mock_type)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
