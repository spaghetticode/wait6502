require 'spec_helper'

describe Admin::AuctionsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/auctions" }.should route_to(:controller => "admin/auctions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/auctions/new" }.should route_to(:controller => "admin/auctions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/auctions/1" }.should route_to(:controller => "admin/auctions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/auctions/1/edit" }.should route_to(:controller => "admin/auctions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/auctions" }.should route_to(:controller => "admin/auctions", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/admin/auctions/1" }.should route_to(:controller => "admin/auctions", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/auctions/1" }.should route_to(:controller => "admin/auctions", :action => "destroy", :id => "1") 
    end
    
    it "recognizes and generates #set_final_price" do
      { :put => "/admin/auctions/1/set_final_price" }.should route_to(:controller => "admin/auctions", :action => "set_final_price", :id => "1") 
    end
  end
end
