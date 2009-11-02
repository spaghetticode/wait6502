require 'spec_helper'

describe "/admin/peripherals/new.html.haml" do

  before(:each) do
    assigns[:peripheral] = stub_model(Peripheral,
      :new_record? => true,
      :name => "value for name",
      :manufacturer => "value for manufacturer",
      :peripheral_type_id => "value for peripheral_type",
      :production_start => "value for production_start",
      :production_stop => "value for production_stop",
      :code => "value for code",
      :ram => "value for ram",
      :rom => "value for rom",
      :notes => "value for notes"
    )
  end

  it "renders new peripheral form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_peripherals_path) do
      with_tag("input#peripheral_name[name=?]", "peripheral[name]")
      with_tag("select#peripheral_manufacturer_id[name=?]", "peripheral[manufacturer_id]")
      with_tag("select#peripheral_peripheral_type_id[name=?]", "peripheral[peripheral_type_id]")
      with_tag("select#peripheral_production_start[name=?]", "peripheral[production_start]")
      with_tag("select#peripheral_production_stop[name=?]", "peripheral[production_stop]")
      with_tag("input#peripheral_code[name=?]", "peripheral[code]")
      with_tag("input#peripheral_ram[name=?]", "peripheral[ram]")
      with_tag("input#peripheral_rom[name=?]", "peripheral[rom]")
      with_tag("textarea#peripheral_notes[name=?]", "peripheral[notes]")
    end
  end
end
