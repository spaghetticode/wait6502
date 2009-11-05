require 'spec_helper'

describe Admin::EbayKeywordsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/hardware/1/ebay_keywords" }.should route_to(:controller => "admin/ebay_keywords", :action => "index", :hardware_id => '1')
    end
    
    it "recognizes and generates #new" do
      { :get => "/admin/hardware/1/ebay_keywords/new" }.should route_to(:controller => "admin/ebay_keywords", :action => "new", :hardware_id => '1')
    end
    
    it "recognizes and generates #create" do
      { :post => "/admin/hardware/1/ebay_keywords" }.should route_to(:controller => "admin/ebay_keywords", :action => "create", :hardware_id => '1')
    end

    it "recognizes and generates #index" do
      { :delete => "/admin/hardware/1/ebay_keywords/1" }.should route_to(:controller => "admin/ebay_keywords", :action => "destroy", :hardware_id => '1', :id => '1')
    end    
  end
end