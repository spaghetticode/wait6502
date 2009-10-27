require 'spec_helper'

describe Admin::OriginalPricesController do
  describe "routing" do
    it "recognizes and generates #create" do
      { :post => "/admin/computers/1/original_prices" }.should route_to(:controller => "admin/original_prices", :action => "create", :computer_id => '1')
    end
    
    it 'recognizes and generates #destroy' do
      { :delete => '/admin/computers/1/original_prices/1'}.should route_to(:controller => 'admin/original_prices', :action => 'destroy', :computer_id => '1', :id => '1')
    end
  end
end
