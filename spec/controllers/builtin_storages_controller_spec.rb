require 'spec_helper'

describe BuiltinStoragesController do

  #Delete these examples and add some real ones
  it "should use BuiltinStoragesController" do
    controller.should be_an_instance_of(BuiltinStoragesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      mock_storage = mock_model(BuiltinStorage, :full_name => 'storage name')
      BuiltinStorage.should_receive(:find).and_return(mock_storage)
      get 'show', :id => 1
      response.should be_success
    end
  end
end
