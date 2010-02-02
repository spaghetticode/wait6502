require 'spec_helper'

describe HardwareController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/old-computers" }.should route_to(:controller => "hardware", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/old-computers/1" }.should route_to(:controller => "hardware", :action => "show", :id => '1')
    end
  end
end