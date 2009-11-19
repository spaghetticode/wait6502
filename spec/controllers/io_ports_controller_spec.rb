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
      IoPort.should_receive(:find)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
