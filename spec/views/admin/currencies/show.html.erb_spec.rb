require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/show.html.erb" do
  include Admin::CurrenciesHelper
  before(:each) do
    assigns[:currency] = @currency = stub_model(Currency,
      :code => "value for code",
      :symbol => "value for symbol"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ code/)
    response.should have_text(/value\ for\ symbol/)
  end
end
