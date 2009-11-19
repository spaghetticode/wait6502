require 'spec_helper'

describe BuiltinLanguagesController do

  #Delete these examples and add some real ones
  it "should use BuiltinLanguagesController" do
    controller.should be_an_instance_of(BuiltinLanguagesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      BuiltinLanguage.should_receive(:find)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
