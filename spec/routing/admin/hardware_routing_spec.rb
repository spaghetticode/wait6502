require 'spec_helper'

describe Admin::HardwareController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/hardware" }.should route_to(:controller => "admin/hardware", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/hardware/new" }.should route_to(:controller => "admin/hardware", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/hardware/1" }.should route_to(:controller => "admin/hardware", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/hardware/1/edit" }.should route_to(:controller => "admin/hardware", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/hardware" }.should route_to(:controller => "admin/hardware", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/hardware/1" }.should route_to(:controller => "admin/hardware", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/hardware/1" }.should route_to(:controller => "admin/hardware", :action => "destroy", :id => "1") 
    end
    
    it "recognizes and generates #add_cpu" do
      { :put => "/admin/hardware/1/add_cpu" }.should route_to(:controller => "admin/hardware", :action => "add_cpu", :id => "1") 
    end
    
    it "recognizes and generates #remove_cpu" do
      { :delete => "/admin/hardware/1/remove_cpu" }.should route_to(:controller => "admin/hardware", :action => "remove_cpu", :id => "1") 
    end
    
    it "recognizes and generates #add_co_cpu" do
      { :put => "/admin/hardware/1/add_co_cpu" }.should route_to(:controller => "admin/hardware", :action => "add_co_cpu", :id => "1") 
    end
    
    it "recognizes and generates #remove_co_cpu" do
      { :delete => "/admin/hardware/1/remove_co_cpu" }.should route_to(:controller => "admin/hardware", :action => "remove_co_cpu", :id => "1") 
    end
    
    it "recognizes and generates #add_builtin_storage" do
      { :put => "/admin/hardware/1/add_builtin_storage" }.should route_to(:controller => "admin/hardware", :action => "add_builtin_storage", :id => "1") 
    end

    it "recognizes and generates #remove_builtin_storage" do
      { :delete => "/admin/hardware/1/remove_builtin_storage" }.should route_to(:controller => "admin/hardware", :action => "remove_builtin_storage", :id => "1") 
    end
    
    it "recognizes and generates #add_io_port" do
      { :put => "/admin/hardware/1/add_io_port" }.should route_to(:controller => "admin/hardware", :action => "add_io_port", :id => "1") 
    end
    
    it "recognizes and generates #remove_io_port" do
      { :delete => "/admin/hardware/1/remove_io_port" }.should route_to(:controller => "admin/hardware", :action => "remove_io_port", :id => "1") 
    end
    
    it "recognizes and generates #add_operative_system" do
      { :put => "/admin/hardware/1/add_operative_system" }.should route_to(:controller => "admin/hardware", :action => "add_operative_system", :id => "1") 
    end
    
    it "recognizes and generates #remove_operative_system" do
      { :delete => "/admin/hardware/1/remove_operative_system" }.should route_to(:controller => "admin/hardware", :action => "remove_operative_system", :id => "1") 
    end
  end
end
