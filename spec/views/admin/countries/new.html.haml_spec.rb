require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/countries/new.html.haml" do
  include Admin::CountriesHelper

  before(:each) do
    assigns[:country] = stub_model(Country,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new country form" do
    render

    response.should have_tag("form[action=?][method=post]", countries_path) do
      with_tag("input#country_name[name=?]", "country[name]")
    end
  end
end
