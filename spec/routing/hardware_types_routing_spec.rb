require 'spec_helper'

describe HardwareTypesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/categories" }.should route_to(:controller => "hardware_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/categories/1" }.should route_to(:controller => "hardware_types", :action => "show", :id => '1')
    end
  end
end