require 'spec_helper'

describe "/admin/hardware/edit.html.haml" do

  before(:each) do
    manufacturer = stub_model(Hardware, :name => 'Apple')
    assigns[:hardware] = @hardware = stub_model(Hardware,
      :new_record? => false,
      :name => "value for name",
      :manufacturer => manufacturer,
      :hardware_type_id => "value for com_type_id",
      :code => "value for code",
      :codename => "value for codename",
      :ram => "value for ram",
      :vram => "value for vram",
      :rom => "value for rom",
      :production_start => "value for production_start",
      :production_stop => 1,
      :builtin_language_id => "value for builtin_language_id",
      :text_modes => "value for text_modes",
      :graphic_modes => "value for graphic_modes",
      :sound => "value for sound"
    )
    assigns[:hardware].stub!(
      :cpus => [],
      :operative_systems => [],
      :builtin_storages => [],
      :co_cpus => [],
      :io_ports => []
    )
  end

  it "renders the edit hardware form" do
    render

    response.should have_tag("form[action=#{admin_hardware_path(@hardware)}][method=post]") do
      with_tag('input#hardware_name[name=?]', "hardware[name]")
      with_tag('select#hardware_manufacturer_id[name=?]', "hardware[manufacturer_id]")
      with_tag('select#hardware_hardware_type_id[name=?]', "hardware[hardware_type_id]")
      with_tag('input#hardware_code[name=?]', "hardware[code]")
      with_tag('input#hardware_codename[name=?]', "hardware[codename]")
      with_tag('input#hardware_ram[name=?]', "hardware[ram]")
      with_tag('input#hardware_vram[name=?]', "hardware[vram]")
      with_tag('input#hardware_rom[name=?]', "hardware[rom]")
      with_tag('select#hardware_production_start[name=?]', "hardware[production_start]")
      with_tag('select#hardware_production_stop[name=?]', "hardware[production_stop]")
      with_tag('select#hardware_builtin_language_id[name=?]', "hardware[builtin_language_id]")
      with_tag('textarea#hardware_text_modes[name=?]', "hardware[text_modes]")
      with_tag('textarea#hardware_graphic_modes[name=?]', "hardware[graphic_modes]")
      with_tag('textarea#hardware_sound[name=?]', "hardware[sound]")
    end
  end
end
