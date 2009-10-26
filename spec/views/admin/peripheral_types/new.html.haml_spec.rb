require 'spec_helper'

describe "/admin/peripheral_types/new.html.haml" do
  include Admin::PeripheralTypesHelper

  before(:each) do
    assigns[:peripheral_type] = stub_model(PeripheralType,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new peripheral_type form" do
    render

    response.should have_tag("form[action=?][method=post]", admin_peripheral_types_path) do
      with_tag("input#peripheral_type_name[name=?]", "peripheral_type[name]")
    end
  end
end
