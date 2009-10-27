require 'spec_helper'

describe Admin::PeripheralsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/peripherals" }.should route_to(:controller => "admin/peripherals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/peripherals/new" }.should route_to(:controller => "admin/peripherals", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/peripherals/1/edit" }.should route_to(:controller => "admin/peripherals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/peripherals" }.should route_to(:controller => "admin/peripherals", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/peripherals/1" }.should route_to(:controller => "admin/peripherals", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/peripherals/1" }.should route_to(:controller => "admin/peripherals", :action => "destroy", :id => "1") 
    end
  end
end
