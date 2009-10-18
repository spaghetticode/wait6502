require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/index.html.erb" do
  include Admin::CurrenciesHelper

  before(:each) do
    assigns[:currencies] = [
      stub_model(Currency,
        :code => "value for code",
        :symbol => "value for symbol"
      ),
      stub_model(Currency,
        :code => "value for code",
        :symbol => "value for symbol"
      )
    ]
  end

  it "renders a list of admin_currencies" do
    render
    response.should have_tag("tr>td", "value for code".to_s, 2)
    response.should have_tag("tr>td", "value for symbol".to_s, 2)
  end
end
