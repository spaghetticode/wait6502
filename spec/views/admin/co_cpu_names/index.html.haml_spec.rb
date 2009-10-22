require 'spec_helper'

describe "/admin/co_cpu_names/index.html.haml" do
  include Admin::CoCpuNamesHelper

  before(:each) do
    assigns[:co_cpu_names] = [
      stub_model(CoCpuName,
        :name => "value for name"
      ),
      stub_model(CoCpuName,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_co_cpu_names" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
