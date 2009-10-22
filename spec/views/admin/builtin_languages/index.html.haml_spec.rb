require 'spec_helper'

describe "/admin/builtin_languages/index.html.haml" do
  include Admin::BuiltinLanguagesHelper

  before(:each) do
    assigns[:builtin_languages] = [
      stub_model(BuiltinLanguage,
        :name => "value for name"
      ),
      stub_model(BuiltinLanguage,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_builtin_languages" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
