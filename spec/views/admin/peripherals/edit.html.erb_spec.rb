require 'spec_helper'

describe "/admin_peripherals/edit.html.erb" do
  include Admin::PeripheralsHelper

  before(:each) do
    assigns[:peripheral] = @peripheral = stub_model(Admin::Peripheral,
      :new_record? => false,
      :name => "value for name",
      :manufacturer => "value for manufacturer",
      :peripheral_type => "value for peripheral_type",
      :production_start => "value for production_start",
      :production_stop => "value for production_stop",
      :code => "value for code",
      :ram => "value for ram",
      :rom => "value for rom",
      :notes => "value for notes"
    )
  end

  it "renders the edit peripheral form" do
    render

    response.should have_tag("form[action=#{peripheral_path(@peripheral)}][method=post]") do
      with_tag('input#peripheral_name[name=?]', "peripheral[name]")
      with_tag('input#peripheral_manufacturer[name=?]', "peripheral[manufacturer]")
      with_tag('input#peripheral_peripheral_type[name=?]', "peripheral[peripheral_type]")
      with_tag('input#peripheral_production_start[name=?]', "peripheral[production_start]")
      with_tag('input#peripheral_production_stop[name=?]', "peripheral[production_stop]")
      with_tag('input#peripheral_code[name=?]', "peripheral[code]")
      with_tag('input#peripheral_ram[name=?]', "peripheral[ram]")
      with_tag('input#peripheral_rom[name=?]', "peripheral[rom]")
      with_tag('textarea#peripheral_notes[name=?]', "peripheral[notes]")
    end
  end
end
