require 'spec_helper'

describe Admin::ComputersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/computers" }.should route_to(:controller => "admin/computers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/computers/new" }.should route_to(:controller => "admin/computers", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/computers/1/edit" }.should route_to(:controller => "admin/computers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/computers" }.should route_to(:controller => "admin/computers", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/computers/1" }.should route_to(:controller => "admin/computers", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/computers/1" }.should route_to(:controller => "admin/computers", :action => "destroy", :id => "1") 
    end
  end
end
