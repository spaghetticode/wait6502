require 'spec_helper'

describe BrandsController do

  #Delete these examples and add some real ones
  it "should use BrandsController" do
    controller.should be_an_instance_of(BrandsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      Manufacturer.should_receive(:find)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
