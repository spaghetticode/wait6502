require 'spec_helper'

describe PeripheralsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/peripherals" }.should route_to(:controller => "peripherals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/peripherals/1" }.should route_to(:controller => "peripherals", :action => "show", :id => '1')
    end
  end
end