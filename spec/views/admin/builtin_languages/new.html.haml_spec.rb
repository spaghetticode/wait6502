require 'spec_helper'

describe "/admin/builtin_languages/new.html.haml" do

  before(:each) do
    assigns[:builtin_language] = stub_model(BuiltinLanguage,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new builtin_language form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_builtin_languages_path) do
      with_tag("input#builtin_language_name[name=?]", "builtin_language[name]")
    end
  end
end
