require 'spec_helper'

describe Admin::CpuNamesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/cpu_names" }.should route_to(:controller => "admin/cpu_names", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/cpu_names/new" }.should route_to(:controller => "admin/cpu_names", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/cpu_names" }.should route_to(:controller => "admin/cpu_names", :action => "create") 
    end

    it "recognizes and generates #delete" do
      { :delete => "/admin/cpu_names/delete" }.should route_to(:controller => "admin/cpu_names", :action => "delete") 
    end
  end
end
