require 'spec_helper'

describe "/admin/cpu_names/new.html.haml" do
  include Admin::CpuNamesHelper

  before(:each) do
    assigns[:cpu_name] = stub_model(CpuName,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new cpu_name form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_cpu_names_path) do
      with_tag("input#cpu_name_name[name=?]", "cpu_name[name]")
    end
  end
end
