require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/index.html.haml" do
  include Admin::CurrenciesHelper

  before(:each) do
    assigns[:currencies] = [
      stub_model(Currency,
        :code => "EUR",
        :symbol => "€"
      ),
      stub_model(Currency,
        :code => "USD",
        :symbol => "$"
      )
    ]
    assigns[:currencies].should_receive(:total_pages).and_return(0)
  end

  it "renders a list of admin_currencies" do
    render
    response.should have_tag("tr>td", "EUR".to_s, 2)
    response.should have_tag("tr>td", "$".to_s, 2)
  end
end
