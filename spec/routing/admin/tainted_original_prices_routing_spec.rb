require 'spec_helper'

describe Admin::TaintedOriginalPricesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/admin/tainted_original_prices" }.should route_to(:controller => "admin/tainted_original_prices", :action => "index")
    end
    
    it "recognizes and generates #approve" do
      { :put => "/admin/tainted_original_prices/1/approve" }.should route_to(:controller => "admin/tainted_original_prices", :action => "approve", :id => '1')
    end
    
    it "recognizes and generates #edit" do
      { :get => "/admin/tainted_original_prices/1/edit" }.should route_to(:controller => "admin/tainted_original_prices", :action => "edit", :id => '1')
    end
    
    it "recognizes and generates #destroy" do
      { :delete => "/admin/tainted_original_prices/1" }.should route_to(:controller => "admin/tainted_original_prices", :action => "destroy", :id => '1')
    end
  end
end
