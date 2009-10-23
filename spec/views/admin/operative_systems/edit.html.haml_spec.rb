require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/operative_systems/edit.html.haml" do
  include Admin::OperativeSystemsHelper

  before(:each) do
    assigns[:operative_system] = @os = stub_model(OperativeSystem,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit operative system form" do
    render

    response.should have_tag("form[action=#{admin_operative_system_path(@os)}][method=post]") do
      with_tag('input#operative_system_name[name=?]', "operative_system[name]")
    end
  end
end