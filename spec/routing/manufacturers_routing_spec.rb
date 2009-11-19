require 'spec_helper'

describe ManufacturersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/manufacturers" }.should route_to(:controller => "manufacturers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/manufacturers/1" }.should route_to(:controller => "manufacturers", :action => "show", :id => '1')
    end
  end
end