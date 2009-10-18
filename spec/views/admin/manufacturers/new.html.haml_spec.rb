require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/new.html.haml" do
  include Admin::ManufacturersHelper

  before(:each) do
    assigns[:manufacturer] = stub_model(Manufacturer,
      :new_record? => true,
      :name => "value for name",
      :country_id => "value for country_id"
    )
  end

  it "renders new manufacturer form" do
    render

    response.should have_tag("form[action=?][method=post]", manufacturers_path) do
      with_tag("input#manufacturer_name[name=?]", "manufacturer[name]")
      with_tag("input#manufacturer_country_id[name=?]", "manufacturer[country_id]")
    end
  end
end
