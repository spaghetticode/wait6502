require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CountriesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/countries", :action => "index").should == "/admin/countries"
    end

    it "maps #new" do
      route_for(:controller => "admin/countries", :action => "new").should == "/admin/countries/new"
    end

    it "maps #destroy" do
      route_for(:controller => "admin/countries", :action => "destroy", :id => "1").should == {:path =>"/admin/countries/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/countries").should == {:controller => "admin/countries", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin/countries/new").should == {:controller => "admin/countries", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin/countries").should == {:controller => "admin/countries", :action => "create"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/admin/countries/1").should == {:controller => "admin/countries", :action => "destroy", :id => "1"}
    end
  end
end
