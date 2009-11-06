require 'spec_helper'

describe "/admin/builtin_languages/index.html.haml" do

  before(:each) do
    assigns[:builtin_languages] = [
      stub_model(BuiltinLanguage,
        :name => "value for name"
      ),
      stub_model(BuiltinLanguage,
        :name => "value for name"
      )
    ]
    assigns[:builtin_languages].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_builtin_languages" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
