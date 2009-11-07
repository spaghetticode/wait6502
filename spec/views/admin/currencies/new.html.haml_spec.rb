require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/currencies/new.html.haml" do

  before(:each) do
    assigns[:currency] = stub_model(Currency,
      :new_record? => true,
      :name => "value for code"
    )
  end

  it "renders new currency form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_currencies_path) do
      with_tag("input#currency_name[name=?]", "currency[name]")
    end
  end
end
