require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/index.html.erb" do
  include Admin::ManufacturersHelper

  before(:each) do
    assigns[:manufacturers] = [
      stub_model(Manufacturer,
        :name => "value for name",
        :country_id => "value for country_id"
      ),
      stub_model(Manufacturer,
        :name => "value for name",
        :country_id => "value for country_id"
      )
    ]
  end

  it "renders a list of admin_manufacturers" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for country_id".to_s, 2)
  end
end
