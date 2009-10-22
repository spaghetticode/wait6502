require 'spec_helper'

describe Admin::BuiltinLanguagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/builtin_languages" }.should route_to(:controller => "admin/builtin_languages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/builtin_languages/new" }.should route_to(:controller => "admin/builtin_languages", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/builtin_languages" }.should route_to(:controller => "admin/builtin_languages", :action => "create") 
    end

    it "recognizes and generates #delete" do
      { :delete => "/admin/builtin_languages/delete" }.should route_to(:controller => "admin/builtin_languages", :action => "delete") 
    end
  end
end
