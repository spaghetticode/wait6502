require 'spec_helper'

describe "/admin/cpu_families/new.html.haml" do
  include Admin::CpuFamiliesHelper

  before(:each) do
    assigns[:cpu_family] = stub_model(CpuFamily,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new cpu_family form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_cpu_families_path) do
      with_tag("input#cpu_family_name[name=?]", "cpu_family[name]")
    end
  end
end
