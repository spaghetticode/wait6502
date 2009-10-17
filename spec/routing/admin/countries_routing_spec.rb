require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CountriesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/countries", :action => "index").should == "/countries"
    end

    it "maps #new" do
      route_for(:controller => "admin/countries", :action => "new").should == "/countries/new"
    end

    it "maps #show" do
      route_for(:controller => "admin/countries", :action => "show", :id => "1").should == "/countries/1"
    end

    it "maps #destroy" do
      route_for(:controller => "admin/countries", :action => "destroy", :id => "1").should == {:path =>"/countries/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/countries").should == {:controller => "admin/countries", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/countries/new").should == {:controller => "admin/countries", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/countries").should == {:controller => "admin/countries", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/countries/1").should == {:controller => "admin/countries", :action => "destroy", :id => "1"}
    end
  end
end
