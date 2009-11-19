require 'spec_helper'

describe CoCpusController do

  #Delete these examples and add some real ones
  it "should use CoCpusController" do
    controller.should be_an_instance_of(CoCpusController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      CoCpu.should_receive(:find)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
