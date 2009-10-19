require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/edit.html.haml" do
  include Admin::CurrenciesHelper

  before(:each) do
    assigns[:currency] = @currency = stub_model(Currency,
      :new_record? => false,
      :code => "value for code",
      :symbol => "value for symbol"
    )
  end

  it "renders the edit currency form" do
    render

    response.should have_tag("form[action=#{admin_currency_path(@currency)}][method=post]") do
      with_tag('input#currency_code[name=?]', "currency[code]")
      with_tag('input#currency_symbol[name=?]', "currency[symbol]")
    end
  end
end
