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
      mock_language = mock_model(BuiltinLanguage, :name => 'language')
      BuiltinLanguage.should_receive(:find).and_return(mock_language)
      get 'show', :id => '1'
      response.should be_success
    end
  end
end
