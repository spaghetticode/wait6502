require 'spec_helper'

describe Admin::CpuFamiliesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/cpu_families" }.should route_to(:controller => "admin/cpu_families", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/cpu_families/new" }.should route_to(:controller => "admin/cpu_families", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/cpu_families" }.should route_to(:controller => "admin/cpu_families", :action => "create") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/cpu_families/delete" }.should route_to(:controller => "admin/cpu_families", :action => "delete") 
    end
  end
end
