require 'spec_helper'

describe "/admin/cpus/edit.html.haml" do

  before(:each) do
    assigns[:cpu] = @cpu = stub_model(Cpu,
      :new_record? => false,
      :cpu_bit_id => "24bit",
      :cpu_family_id => "68K",
      :manufacturer_id => 1,
      :cpu_name_id => "Motorola 68000",
      :clock => "7.16Mhz",
      :full_name => "Motorola 68K @7.16Mhz"
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
      with_tag("select#cpu_parent_cpu_id[name=?]", "cpu[parent_cpu_id]")
    end
  end
end
