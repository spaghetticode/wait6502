require 'spec_helper'

describe Admin::CoCpusController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/co_cpus" }.should route_to(:controller => "admin/co_cpus", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/co_cpus/new" }.should route_to(:controller => "admin/co_cpus", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/co_cpus/1/edit" }.should route_to(:controller => "admin/co_cpus", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/co_cpus" }.should route_to(:controller => "admin/co_cpus", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/co_cpus/1" }.should route_to(:controller => "admin/co_cpus", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/co_cpus/1" }.should route_to(:controller => "admin/co_cpus", :action => "destroy", :id => "1") 
    end
  end
end
