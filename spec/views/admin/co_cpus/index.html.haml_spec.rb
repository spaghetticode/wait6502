require 'spec_helper'

describe "admin/co_cpus/index.html.haml" do

  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'Manufacturer')
    assigns[:co_cpus] = [
      stub_model(CoCpu,
        :co_cpu_name_id => "value for co_cpu_name_id",
        :co_cpu_type_id => "value for co_cpu_type_id",
        :manufacturer => manufacturer
      ),
      stub_model(CoCpu,
        :co_cpu_name_id => "value for co_cpu_name_id",
        :co_cpu_type_id => "value for co_cpu_type_id",
        :manufacturer => manufacturer
      )
    ]
  end

  it "renders a list of co_cpus" do
    render
    response.should have_tag("tr>td", "value for co_cpu_name_id".to_s, 2)
    response.should have_tag("tr>td", "value for co_cpu_type_id".to_s, 2)
    response.should have_tag("tr>td", "Manufacturer", 2)
  end
end
