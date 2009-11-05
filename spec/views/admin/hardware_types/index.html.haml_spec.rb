require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/hardware_types/index.html.haml" do

  before(:each) do
    assigns[:hardware_types] = [
      stub_model(HardwareType,
        :name => "value for name"
      ),
      stub_model(HardwareType,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_hardware_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
