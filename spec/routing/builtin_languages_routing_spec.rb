require 'spec_helper'

describe BuiltinLanguagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/builtin-languages" }.should route_to(:controller => "builtin_languages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/builtin-languages/1" }.should route_to(:controller => "builtin_languages", :action => "show", :id => '1')
    end
  end
end