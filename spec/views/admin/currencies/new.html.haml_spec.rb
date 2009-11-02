require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/new.html.haml" do

  before(:each) do
    assigns[:currency] = stub_model(Currency,
      :new_record? => true,
      :code => "value for code",
      :symbol => "value for symbol"
    )
  end

  it "renders new currency form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_currencies_path) do
      with_tag("input#currency_code[name=?]", "currency[code]")
      with_tag("input#currency_symbol[name=?]", "currency[symbol]")
    end
  end
end
