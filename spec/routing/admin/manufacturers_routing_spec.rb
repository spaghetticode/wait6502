require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ManufacturersController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/manufacturers", :action => "index").should == "/admin/manufacturers"
    end

    it "maps #new" do
      route_for(:controller => "admin/manufacturers", :action => "new").should == "/admin/manufacturers/new"
    end

    it "maps #show" do
      route_for(:controller => "admin/manufacturers", :action => "show", :id => "1").should == "/admin/manufacturers/1"
    end

    it "maps #edit" do
      route_for(:controller => "admin/manufacturers", :action => "edit", :id => "1").should == "/admin/manufacturers/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "admin/manufacturers", :action => "create").should == {:path => "/admin/manufacturers", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "admin/manufacturers", :action => "update", :id => "1").should == {:path =>"/admin/manufacturers/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/manufacturers", :action => "destroy", :id => "1").should == {:path =>"/admin/manufacturers/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/manufacturers").should == {:controller => "admin/manufacturers", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin/manufacturers/new").should == {:controller => "admin/manufacturers", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin/manufacturers").should == {:controller => "admin/manufacturers", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/admin/manufacturers/1").should == {:controller => "admin/manufacturers", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/admin/manufacturers/1/edit").should == {:controller => "admin/manufacturers", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/admin/manufacturers/1").should == {:controller => "admin/manufacturers", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin/manufacturers/1").should == {:controller => "admin/manufacturers", :action => "destroy", :id => "1"}
    end
  end
end
