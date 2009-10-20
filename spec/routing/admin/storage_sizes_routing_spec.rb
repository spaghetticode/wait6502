require 'spec_helper'

describe Admin::StorageSizesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/storage_sizes" }.should route_to(:controller => "admin/storage_sizes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/storage_sizes/new" }.should route_to(:controller => "admin/storage_sizes", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/storage_sizes" }.should route_to(:controller => "admin/storage_sizes", :action => "create") 
    end

    it "recognizes and generates #delete" do
      { :delete => "/admin/storage_sizes/delete" }.should route_to(:controller => "admin/storage_sizes", :action => "delete") 
    end
  end
end
