require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CurrenciesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/currencies", :action => "index").should == "/currencies"
    end

    it "maps #new" do
      route_for(:controller => "admin/currencies", :action => "new").should == "/currencies/new"
    end

    it "maps #edit" do
      route_for(:controller => "admin/currencies", :action => "edit", :id => "1").should == "/currencies/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "admin/currencies", :action => "create").should == {:path => "/currencies", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "admin/currencies", :action => "update", :id => "1").should == {:path =>"/currencies/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/currencies", :action => "destroy", :id => "1").should == {:path =>"/currencies/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/currencies").should == {:controller => "admin/currencies", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/currencies/new").should == {:controller => "admin/currencies", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/currencies").should == {:controller => "admin/currencies", :action => "create"}
    end

    it "generates params for #edit" do
      params_from(:get, "/currencies/1/edit").should == {:controller => "admin/currencies", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/currencies/1").should == {:controller => "admin/currencies", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/currencies/1").should == {:controller => "admin/currencies", :action => "destroy", :id => "1"}
    end
  end
end
