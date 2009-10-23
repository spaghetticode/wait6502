require 'spec_helper'

describe "/admin/computers/edit.html.haml" do
  include Admin::ComputersHelper

  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'Apple')
    assigns[:computer] = @computer = stub_model(Computer,
      :new_record? => false,
      :name => "value for name",
      :manufacturer => manufacturer,
      :computer_type_id => "value for com_type_id",
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
    assigns[:computer].stub!(:cpus => [], :operative_systems => [], :builtin_storages => [], :co_cpus => [])
  end

  it "renders the edit computer form" do
    render

    response.should have_tag("form[action=#{admin_computer_path(@computer)}][method=post]") do
      with_tag('input#computer_name[name=?]', "computer[name]")
      with_tag('select#computer_manufacturer_id[name=?]', "computer[manufacturer_id]")
      with_tag('select#computer_computer_type_id[name=?]', "computer[computer_type_id]")
      with_tag('input#computer_code[name=?]', "computer[code]")
      with_tag('input#computer_codename[name=?]', "computer[codename]")
      with_tag('input#computer_ram[name=?]', "computer[ram]")
      with_tag('input#computer_vram[name=?]', "computer[vram]")
      with_tag('input#computer_rom[name=?]', "computer[rom]")
      with_tag('select#computer_production_start[name=?]', "computer[production_start]")
      with_tag('select#computer_production_stop[name=?]', "computer[production_stop]")
      with_tag('select#computer_builtin_language_id[name=?]', "computer[builtin_language_id]")
      with_tag('textarea#computer_text_modes[name=?]', "computer[text_modes]")
      with_tag('textarea#computer_graphic_modes[name=?]', "computer[graphic_modes]")
      with_tag('textarea#computer_sound[name=?]', "computer[sound]")
    end
  end
end
