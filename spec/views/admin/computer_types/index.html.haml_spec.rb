require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/computer_types/index.html.haml" do
  include Admin::ComputerTypesHelper

  before(:each) do
    assigns[:computer_types] = [
      stub_model(ComputerType,
        :name => "value for name"
      ),
      stub_model(ComputerType,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_computer_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
