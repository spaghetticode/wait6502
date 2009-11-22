require 'spec_helper'

describe OriginalPricesController do

  #Delete these examples and add some real ones
  it "should use OriginalPricesController" do
    controller.should be_an_instance_of(OriginalPricesController)
  end


  describe "GET 'create_tainted'" do
    it "should be successful" do
      mock_hardware = mock_model(Hardware).as_null_object
      Hardware.should_receive(:find).with('1').and_return(mock_hardware)
      post 'create_tainted', :original_price => {}, :hardware_id => '1'
      response.should be_success
    end
  end
end
