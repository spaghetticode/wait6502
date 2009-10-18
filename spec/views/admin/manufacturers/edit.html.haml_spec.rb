require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/edit.html.haml" do
  include Admin::ManufacturersHelper

  before(:each) do
    assigns[:manufacturer] = @manufacturer = stub_model(Manufacturer,
      :new_record? => false,
      :name => "value for name",
      :country_id => "value for country_id"
    )
  end

  it "renders the edit manufacturer form" do
    render

    response.should have_tag("form[action=#{manufacturer_path(@manufacturer)}][method=post]") do
      with_tag('input#manufacturer_name[name=?]', "manufacturer[name]")
      with_tag('input#manufacturer_country_id[name=?]', "manufacturer[country_id]")
    end
  end
end
