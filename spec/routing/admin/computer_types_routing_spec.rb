require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ComputerTypesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/computer_types", :action => "index").should == "/computer_types"
    end

    it "maps #new" do
      route_for(:controller => "admin/computer_types", :action => "new").should == "/computer_types/new"
    end

    it "maps #create" do
      route_for(:controller => "admin/computer_types", :action => "create").should == {:path => "/computer_types", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/computer_types", :action => "destroy", :id => "1").should == {:path =>"/computer_types/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/computer_types").should == {:controller => "admin/computer_types", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/computer_types/new").should == {:controller => "admin/computer_types", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/computer_types").should == {:controller => "admin/computer_types", :action => "create"}
    end
    
    it "generates params for #destroy" do
      params_from(:delete, "/computer_types/1").should == {:controller => "admin/computer_types", :action => "destroy", :id => "1"}
    end
  end
end