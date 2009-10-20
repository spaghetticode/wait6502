require 'spec_helper'

describe Admin::BuiltinStoragesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/builtin_storages" }.should route_to(:controller => "admin/builtin_storages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/builtin_storages/new" }.should route_to(:controller => "admin/builtin_storages", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/builtin_storages/1/edit" }.should route_to(:controller => "admin/builtin_storages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/builtin_storages" }.should route_to(:controller => "admin/builtin_storages", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/builtin_storages/1" }.should route_to(:controller => "admin/builtin_storages", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/builtin_storages/1" }.should route_to(:controller => "admin/builtin_storages", :action => "destroy", :id => "1") 
    end
  end
end
