require 'spec_helper'

describe ComputersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/old-computers" }.should route_to(:controller => "computers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/old-computers/1" }.should route_to(:controller => "computers", :action => "show", :id => '1')
    end
  end
end