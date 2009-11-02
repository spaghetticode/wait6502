require 'spec_helper'

describe "/admin/cpu_families/index.html.haml" do

  before(:each) do
    assigns[:cpu_families] = [
      stub_model(CpuFamily,
        :name => "value for name"
      ),
      stub_model(CpuFamily,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of admin_cpu_families" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
