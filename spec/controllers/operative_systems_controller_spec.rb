require 'spec_helper'

describe OperativeSystemsController do

  #Delete these examples and add some real ones
  it "should use OperativeSystemsController" do
    controller.should be_an_instance_of(OperativeSystemsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      OperativeSystem.should_receive(:find)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
