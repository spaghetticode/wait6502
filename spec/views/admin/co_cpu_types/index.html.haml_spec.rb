require 'spec_helper'

describe "/admin/co_cpu_types/index.html.haml" do
  before(:each) do
    assigns[:co_cpu_types] = [
      stub_model(CoCpuType),
      stub_model(CoCpuType)
    ]
  end

  it "renders a list of admin_co_cpu_types" do
    render
  end
end
