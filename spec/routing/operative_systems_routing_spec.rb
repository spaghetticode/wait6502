require 'spec_helper'

describe OperativeSystemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/operative-systems" }.should route_to(:controller => "operative_systems", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/operative-systems/1" }.should route_to(:controller => "operative_systems", :action => "show", :id => '1')
    end
  end
end