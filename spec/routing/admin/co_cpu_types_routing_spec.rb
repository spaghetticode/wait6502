require 'spec_helper'

describe Admin::CoCpuTypesController do
    describe "routing" do
      it "recognizes and generates #index" do
        { :get => "/admin/co_cpu_types" }.should route_to(:controller => "admin/co_cpu_types", :action => "index")
      end

      it "recognizes and generates #new" do
        { :get => "/admin/co_cpu_types/new" }.should route_to(:controller => "admin/co_cpu_types", :action => "new")
      end

      it "recognizes and generates #create" do
        { :post => "/admin/co_cpu_types" }.should route_to(:controller => "admin/co_cpu_types", :action => "create") 
      end

      it "recognizes and generates #delete" do
        { :delete => "/admin/co_cpu_types/delete" }.should route_to(:controller => "admin/co_cpu_types", :action => "delete") 
      end
    end
  end
