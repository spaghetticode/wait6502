require 'spec_helper'

describe Admin::ImagesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/computers/1/images" }.should route_to(:controller => "admin/images", :action => "index", :computer_id => '1')
    end
    
    it "recognizes and generates #new" do
      { :get => "/admin/computers/1/images/new" }.should route_to(:controller => "admin/images", :action => "new", :computer_id => '1')
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/computers/1/images/2/edit" }.should route_to(:controller => "admin/images", :action => "edit", :id => "2", :computer_id => '1')
    end

    it "recognizes and generates #create" do
      { :post => "/admin/computers/1/images" }.should route_to(:controller => "admin/images", :action => "create", :computer_id => '1') 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/computers/1/images/2" }.should route_to(:controller => "admin/images", :action => "update", :id => "2", :computer_id => '1') 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/computers/1/images/2" }.should route_to(:controller => "admin/images", :action => "destroy", :id => "2", :computer_id => '1') 
    end
  end
end
