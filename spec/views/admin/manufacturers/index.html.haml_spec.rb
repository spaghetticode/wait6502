require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/index.html.haml" do
  include Admin::ManufacturersHelper

  before(:each) do
    assigns[:manufacturers] = [
      stub_model(Manufacturer,
        :name => "Apple",
        :country_id => "USA"
      ),
      stub_model(Manufacturer,
        :name => "Olivetti",
        :country_id => "Italy"
      )
    ]
    assigns[:manufacturers].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_manufacturers" do
    render
    response.should have_tag("tr>td", "Apple".to_s, 2)
    response.should have_tag("tr>td", "USA".to_s, 2)
  end
end
