require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/computer_types/new.html.haml" do
  include Admin::ComputerTypesHelper

  before(:each) do
    assigns[:computer_type] = stub_model(ComputerType,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new computer_type form" do
    render

    response.should have_tag("form[action=?][method=post]", computer_types_path) do
      with_tag("input#computer_type_name[name=?]", "computer_type[name]")
    end
  end
end
