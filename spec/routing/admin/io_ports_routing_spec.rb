require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::IoPortsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/io_ports", :action => "index").should == "/io_ports"
    end

    it "maps #new" do
      route_for(:controller => "admin/io_ports", :action => "new").should == "/io_ports/new"
    end

    it "maps #edit" do
      route_for(:controller => "admin/io_ports", :action => "edit", :id => "1").should == "/io_ports/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "admin/io_ports", :action => "create").should == {:path => "/io_ports", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "admin/io_ports", :action => "update", :id => "1").should == {:path =>"/io_ports/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/io_ports", :action => "destroy", :id => "1").should == {:path =>"/io_ports/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/io_ports").should == {:controller => "admin/io_ports", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/io_ports/new").should == {:controller => "admin/io_ports", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/io_ports").should == {:controller => "admin/io_ports", :action => "create"}
    end

    it "generates params for #edit" do
      params_from(:get, "/io_ports/1/edit").should == {:controller => "admin/io_ports", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/io_ports/1").should == {:controller => "admin/io_ports", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/io_ports/1").should == {:controller => "admin/io_ports", :action => "destroy", :id => "1"}
    end
  end
end
