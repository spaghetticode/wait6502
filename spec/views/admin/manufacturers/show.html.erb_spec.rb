require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/show.html.erb" do
  include Admin::ManufacturersHelper
  before(:each) do
    assigns[:manufacturer] = @manufacturer = stub_model(Manufacturer,
      :name => "value for name",
      :country_id => "value for country_id"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ country_id/)
  end
end
