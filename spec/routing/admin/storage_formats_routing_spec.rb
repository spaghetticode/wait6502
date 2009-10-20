require 'spec_helper'

describe Admin::StorageFormatsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/storage_formats" }.should route_to(:controller => "admin/storage_formats", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/storage_formats/new" }.should route_to(:controller => "admin/storage_formats", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/storage_formats" }.should route_to(:controller => "admin/storage_formats", :action => "create") 
    end
    
    it "recognizes and generates #delete" do
      { :delete => "/admin/storage_formats/delete" }.should route_to(:controller => "admin/storage_formats", :action => "delete") 
    end
  end
end
