require 'spec_helper'

describe Admin::StorageNamesController do

  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/storage_names" }.should route_to(:controller => "admin/storage_names", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/storage_names/new" }.should route_to(:controller => "admin/storage_names", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/storage_names" }.should route_to(:controller => "admin/storage_names", :action => "create") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/storage_names/1" }.should route_to(:controller => "admin/storage_names", :action => "destroy", :id => "1") 
    end
  end
end
