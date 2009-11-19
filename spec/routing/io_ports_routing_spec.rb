require 'spec_helper'

describe IoPortsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/io-ports" }.should route_to(:controller => "io_ports", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/io-ports/1" }.should route_to(:controller => "io_ports", :action => "show", :id => '1')
    end
  end
end