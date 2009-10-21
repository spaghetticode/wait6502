require 'spec_helper'

describe Admin::CpusController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/cpus" }.should route_to(:controller => "admin/cpus", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/cpus/new" }.should route_to(:controller => "admin/cpus", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/cpus/1" }.should route_to(:controller => "admin/cpus", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/cpus/1/edit" }.should route_to(:controller => "admin/cpus", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/cpus" }.should route_to(:controller => "admin/cpus", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/cpus/1" }.should route_to(:controller => "admin/cpus", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/cpus/1" }.should route_to(:controller => "admin/cpus", :action => "destroy", :id => "1") 
    end
  end
end
