require 'spec_helper'

describe "/admin/cpus/new.html.haml" do

  before(:each) do
    assigns[:cpu] = stub_model(Cpu, :new_record? => true)
  end

  it "renders new cpu form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_cpus_path) do
      with_tag("select#cpu_cpu_bit_id[name=?]", "cpu[cpu_bit_id]")
      with_tag("select#cpu_cpu_family_id[name=?]", "cpu[cpu_family_id]")
      with_tag("select#cpu_manufacturer_id[name=?]", "cpu[manufacturer_id]")
      with_tag("select#cpu_cpu_name_id[name=?]", "cpu[cpu_name_id]")
      with_tag("input#cpu_clock[name=?]", "cpu[clock]")
      with_tag("select#cpu_parent_cpu_id[name=?]", "cpu[parent_cpu_id]")
    end
  end
end
