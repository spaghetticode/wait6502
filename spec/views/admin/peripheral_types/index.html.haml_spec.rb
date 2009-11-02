require 'spec_helper'

describe "/admin/peripheral_types/index.html.haml" do

  before(:each) do
    assigns[:peripheral_types] = [
      stub_model(PeripheralType,
        :name => "value for name"
      ),
      stub_model(PeripheralType,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_peripheral_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
