require 'spec_helper'

describe IoPortsController do

  #Delete these examples and add some real ones
  it "should use IoPortsController" do
    controller.should be_an_instance_of(IoPortsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      mock_port = mock_model(IoPort, :name => 'serial')
      IoPort.should_receive(:find).and_return(mock_port)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
