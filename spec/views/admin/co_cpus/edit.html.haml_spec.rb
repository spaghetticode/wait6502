require 'spec_helper'

describe "/admin/co_cpus/edit.html.haml" do

  before(:each) do
    assigns[:co_cpu] = @co_cpu = stub_model(CoCpu,
      :new_record? => false,
      :co_cpu_name_id => "value for co_cpu_name_id",
      :co_cpu_type_id => "value for co_cpu_type_id",
      :manufacturer_id => 1
    )
  end

  it "renders the edit co_cpu form" do
    render

    response.should have_tag("form[action=#{admin_co_cpu_path(@co_cpu)}][method=post]") do
      with_tag('select#co_cpu_co_cpu_name_id[name=?]', "co_cpu[co_cpu_name_id]")
      with_tag('select#co_cpu_co_cpu_type_id[name=?]', "co_cpu[co_cpu_type_id]")
      with_tag('select#co_cpu_manufacturer_id[name=?]', "co_cpu[manufacturer_id]")
    end
  end
end
