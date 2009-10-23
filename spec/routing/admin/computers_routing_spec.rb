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
    
    it "recognizes and generates #add_cpu" do
      { :put => "/admin/computers/1/add_cpu" }.should route_to(:controller => "admin/computers", :action => "add_cpu", :id => "1") 
    end
    
    it "recognizes and generates #remove_cpu" do
      { :delete => "/admin/computers/1/remove_cpu" }.should route_to(:controller => "admin/computers", :action => "remove_cpu", :id => "1") 
    end
    
    it "recognizes and generates #add_co_cpu" do
      { :put => "/admin/computers/1/add_co_cpu" }.should route_to(:controller => "admin/computers", :action => "add_co_cpu", :id => "1") 
    end
    
    it "recognizes and generates #remove_co_cpu" do
      { :delete => "/admin/computers/1/remove_co_cpu" }.should route_to(:controller => "admin/computers", :action => "remove_co_cpu", :id => "1") 
    end
    
    it "recognizes and generates #add_builtin_storage" do
      { :put => "/admin/computers/1/add_builtin_storage" }.should route_to(:controller => "admin/computers", :action => "add_builtin_storage", :id => "1") 
    end

    it "recognizes and generates #remove_builtin_storage" do
      { :delete => "/admin/computers/1/remove_builtin_storage" }.should route_to(:controller => "admin/computers", :action => "remove_builtin_storage", :id => "1") 
    end
    
    it "recognizes and generates #add_io_port" do
      { :put => "/admin/computers/1/add_io_port" }.should route_to(:controller => "admin/computers", :action => "add_io_port", :id => "1") 
    end
    
    it "recognizes and generates #remove_io_port" do
      { :delete => "/admin/computers/1/remove_io_port" }.should route_to(:controller => "admin/computers", :action => "remove_io_port", :id => "1") 
    end
    
    it "recognizes and generates #add_operative_system" do
      { :put => "/admin/computers/1/add_operative_system" }.should route_to(:controller => "admin/computers", :action => "add_operative_system", :id => "1") 
    end
    
    it "recognizes and generates #remove_operative_system" do
      { :delete => "/admin/computers/1/remove_operative_system" }.should route_to(:controller => "admin/computers", :action => "remove_operative_system", :id => "1") 
    end
  end
end
