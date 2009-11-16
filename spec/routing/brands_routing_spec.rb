require 'spec_helper'

describe BrandsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/brands" }.should route_to(:controller => "brands", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/brands/1" }.should route_to(:controller => "brands", :action => "show", :id => '1')
    end
  end
end