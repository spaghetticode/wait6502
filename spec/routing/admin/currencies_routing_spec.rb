require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CurrenciesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/currencies", :action => "index").should == "/admin/currencies"
    end

    it "maps #new" do
      route_for(:controller => "admin/currencies", :action => "new").should == "/admin/currencies/new"
    end

    it "maps #create" do
      route_for(:controller => "admin/currencies", :action => "create").should == {:path => "/admin/currencies", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/currencies", :action => "destroy", :id => "1").should == {:path =>"/admin/currencies/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/currencies").should == {:controller => "admin/currencies", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin/currencies/new").should == {:controller => "admin/currencies", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin/currencies").should == {:controller => "admin/currencies", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin/currencies/1").should == {:controller => "admin/currencies", :action => "destroy", :id => "1"}
    end
  end
end
