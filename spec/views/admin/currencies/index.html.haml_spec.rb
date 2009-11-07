require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/index.html.haml" do

  before(:each) do
    assigns[:currencies] = [
      stub_model(Currency,
        :name => "EUR"
      ),
      stub_model(Currency,
        :name => "USD"
      )
    ]
    assigns[:currencies].should_receive(:total_pages).and_return(0)
  end

  it "renders a list of admin_currencies" do
    render
    response.should have_tag("tr>td", "EUR".to_s, 2)
  end
end
