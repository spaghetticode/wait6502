require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/hardware_types/new.html.haml" do

  before(:each) do
    assigns[:hardware_type] = stub_model(HardwareType,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new hardware_type form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_hardware_types_path) do
      with_tag("input#hardware_type_name[name=?]", "hardware_type[name]")
    end
  end
end
