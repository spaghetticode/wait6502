require 'spec_helper'

describe Admin::PeripheralTypesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/peripheral_types" }.should route_to(:controller => "admin/peripheral_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/peripheral_types/new" }.should route_to(:controller => "admin/peripheral_types", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/peripheral_types" }.should route_to(:controller => "admin/peripheral_types", :action => "create") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/peripheral_types/1" }.should route_to(:controller => "admin/peripheral_types", :action => "destroy", :id => "1") 
    end
  end
end
