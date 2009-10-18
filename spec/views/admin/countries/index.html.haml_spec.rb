require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/countries/index.html.haml" do
  include Admin::CountriesHelper

  before(:each) do
    assigns[:countries] = [
      stub_model(Country,
        :name => "Italy"
      ),
      stub_model(Country,
        :name => "USA"
      )
    ]
    assigns[:countries].stub!(:total_pages).and_return(0)
  end

  it "renders a list of countries" do
    render
    response.should have_tag("tr>td", "Italy".to_s, 2)
  end
end
