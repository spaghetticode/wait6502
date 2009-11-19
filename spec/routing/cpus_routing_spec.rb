require 'spec_helper'

describe CpusController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/cpu" }.should route_to(:controller => "cpus", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cpu/1" }.should route_to(:controller => "cpus", :action => "show", :id => '1')
    end
  end
end