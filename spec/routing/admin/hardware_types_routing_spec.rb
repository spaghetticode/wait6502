require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::HardwareTypesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "admin/hardware_types", :action => "index").should == "/admin/hardware_types"
    end

    it "maps #new" do
      route_for(:controller => "admin/hardware_types", :action => "new").should == "/admin/hardware_types/new"
    end

    it "maps #create" do
      route_for(:controller => "admin/hardware_types", :action => "create").should == {:path => "/admin/hardware_types", :method => :post}
    end

    it "maps #destroy" do
      route_for(:controller => "admin/hardware_types", :action => "destroy", :id => "1").should == {:path =>"/admin/hardware_types/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/admin/hardware_types").should == {:controller => "admin/hardware_types", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/admin/hardware_types/new").should == {:controller => "admin/hardware_types", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/admin/hardware_types").should == {:controller => "admin/hardware_types", :action => "create"}
    end
    
    it "generates params for #destroy" do
      params_from(:delete, "/admin/hardware_types/1").should == {:controller => "admin/hardware_types", :action => "destroy", :id => "1"}
    end
  end
end
