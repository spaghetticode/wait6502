require 'spec_helper'

describe "/admin/cpus/edit.html.haml" do

  before(:each) do
    assigns[:cpu] = @cpu = stub_model(Cpu,
      :new_record? => false,
      :cpu_bit_id => "value for cpu_bit_id",
      :cpu_family_id => "value for cpu_family_id",
      :manufacturer_id => 1,
      :cpu_name_id => "value for cpu_name_id",
      :clock => "value for clock"
    )
  end

  it "renders the edit cpu form" do
    render

    response.should have_tag("form[action=#{admin_cpu_path(@cpu)}][method=post]") do
      with_tag('select#cpu_cpu_bit_id[name=?]', "cpu[cpu_bit_id]")
      with_tag('select#cpu_cpu_family_id[name=?]', "cpu[cpu_family_id]")
      with_tag('select#cpu_manufacturer_id[name=?]', "cpu[manufacturer_id]")
      with_tag('select#cpu_cpu_name_id[name=?]', "cpu[cpu_name_id]")
      with_tag('input#cpu_clock[name=?]', "cpu[clock]")
    end
  end
end
