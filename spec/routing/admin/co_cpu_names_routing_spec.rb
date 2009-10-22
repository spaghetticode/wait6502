require 'spec_helper'

describe Admin::CoCpuNamesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/co_cpu_names" }.should route_to(:controller => "admin/co_cpu_names", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/co_cpu_names/new" }.should route_to(:controller => "admin/co_cpu_names", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/co_cpu_names" }.should route_to(:controller => "admin/co_cpu_names", :action => "create") 
    end

    it "recognizes and generates #delete" do
      { :delete => "/admin/co_cpu_names/delete" }.should route_to(:controller => "admin/co_cpu_names", :action => "delete") 
    end
  end
end
