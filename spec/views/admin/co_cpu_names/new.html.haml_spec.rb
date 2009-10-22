require 'spec_helper'

describe "/admin/co_cpu_names/new.html.haml" do
  include Admin::CoCpuNamesHelper

  before(:each) do
    assigns[:co_cpu_name] = stub_model(CoCpuName,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new co_cpu_name form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_co_cpu_names_path) do
      with_tag("input#co_cpu_name_name[name=?]", "co_cpu_name[name]")
    end
  end
end
