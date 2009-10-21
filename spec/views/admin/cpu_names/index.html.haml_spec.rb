require 'spec_helper'

describe "/admin/cpu_names/index.html.haml" do
  include Admin::CpuNamesHelper

  before(:each) do
    assigns[:cpu_names] = [
      stub_model(CpuName,
        :name => "value for name"
      ),
      stub_model(CpuName,
        :name => "value for name"
      )
    ]
    assigns[:cpu_names].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_cpu_names" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
