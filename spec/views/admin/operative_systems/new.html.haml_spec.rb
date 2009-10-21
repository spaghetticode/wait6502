require 'spec_helper'

describe "/admin/operative_systems/new.html.haml" do
  include Admin::OperativeSystemsHelper

  before(:each) do
    assigns[:operative_system] = stub_model(OperativeSystem,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new operative_system form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_operative_systems_path) do
      with_tag("input#operative_system_name[name=?]", "operative_system[name]")
    end
  end
end
