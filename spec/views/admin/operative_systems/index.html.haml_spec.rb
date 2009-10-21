require 'spec_helper'

describe "/admin/operative_systems/index.html.haml" do
  include Admin::OperativeSystemsHelper

  before(:each) do
    assigns[:operative_systems] = [
      stub_model(OperativeSystem,
        :name => "value for name"
      ),
      stub_model(OperativeSystem,
        :name => "value for name"
      )
    ]
    assigns[:operative_systems].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_operative_systems" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
