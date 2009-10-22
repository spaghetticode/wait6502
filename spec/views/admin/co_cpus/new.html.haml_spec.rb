require 'spec_helper'

describe "/admin/co_cpus/new.html.haml" do
  include Admin::CoCpusHelper

  before(:each) do
    assigns[:co_cpu] = stub_model(CoCpu,
      :new_record? => true,
      :co_cpu_name_id => "value for co_cpu_name_id",
      :co_cpu_type_id => "value for co_cpu_type_id",
      :manufacturer_id => 1
    )
  end

  it "renders new co_cpu form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_co_cpus_path) do
      with_tag("select#co_cpu_co_cpu_name_id[name=?]", "co_cpu[co_cpu_name_id]")
      with_tag("select#co_cpu_co_cpu_type_id[name=?]", "co_cpu[co_cpu_type_id]")
      with_tag("select#co_cpu_manufacturer_id[name=?]", "co_cpu[manufacturer_id]")
    end
  end
end
