require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/countries/index.html.haml" do
  include Admin::CountriesHelper

  before(:each) do
    assigns[:countries] = [
      stub_model(Country,
        :name => "value for name"
      ),
      stub_model(Country,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of countries" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
