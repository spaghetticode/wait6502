require 'spec_helper'

describe "/admin/peripherals/index.html.erb" do
  include Admin::PeripheralsHelper

  before(:each) do
    manufacturer = mock_model(Manufacturer, :name => 'Apple')
    assigns[:peripherals] = [
      stub_model(Peripheral,
        :name => "value for name",
        :manufacturer => manufacturer,
        :peripheral_type_id => 'Printer',
        :production_start => "1981",
        :production_stop => "1982",
        :code => "value for code",
        :ram => "value for ram",
        :rom => "value for rom",
        :notes => "value for notes"
      ),
      stub_model(Peripheral,
        :name => "value for name",
        :manufacturer => manufacturer,
        :peripheral_type_id => 'Printer',
        :production_start => "1981",
        :production_stop => "1982",
        :code => "value for code",
        :ram => "value for ram",
        :rom => "value for rom",
        :notes => "value for notes"
      )
    ]
  end

  it "renders a list of admin_peripherals" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "Apple".to_s, 2)
    response.should have_tag("tr>td", "Printer".to_s, 2)
    response.should have_tag("tr>td", "1982".to_s, 2)
    response.should have_tag("tr>td", "1981".to_s, 2)
    response.should have_tag("tr>td", "value for code".to_s, 2)
    response.should have_tag("tr>td", "value for ram".to_s, 2)
    response.should have_tag("tr>td", "value for rom".to_s, 2)
    response.should have_tag("tr>td", "value for notes".to_s, 2)
  end
end
