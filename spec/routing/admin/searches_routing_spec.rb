require 'spec_helper'

describe SearchesController do
  describe "routing" do
    it "recognizes and generates #create" do
      { :get => "/search?query=Amiga" }.should route_to(:controller => "searches", :action => "create", :query => 'Amiga')
    end
  end
end