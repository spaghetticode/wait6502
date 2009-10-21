require 'spec_helper'

describe Admin::OperativeSystemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/operative_systems" }.should route_to(:controller => "admin/operative_systems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/operative_systems/new" }.should route_to(:controller => "admin/operative_systems", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/operative_systems" }.should route_to(:controller => "admin/operative_systems", :action => "create") 
    end

    it "recognizes and generates #delete" do
      { :delete => "/admin/operative_systems/delete" }.should route_to(:controller => "admin/operative_systems", :action => "delete") 
    end
  end
end
