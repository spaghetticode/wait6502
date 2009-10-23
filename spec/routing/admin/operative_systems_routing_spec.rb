require 'spec_helper'

describe Admin::OperativeSystemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/operative_systems" }.should route_to(:controller => "admin/operative_systems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/operative_systems/new" }.should route_to(:controller => "admin/operative_systems", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/operative_systems/1/edit" }.should route_to(:controller => "admin/operative_systems", :action => "edit", :id => '1') 
    end
    
    it "recognizes and generates #create" do
      { :post => "/admin/operative_systems" }.should route_to(:controller => "admin/operative_systems", :action => "create") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/operative_systems/1" }.should route_to(:controller => "admin/operative_systems", :action => "destroy", :id => '1') 
    end
  end
end
