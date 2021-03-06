require 'spec_helper'

describe "/admin/cpus/index.html.haml" do

  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'Manufacturer')
    assigns[:cpus] = [
      stub_model(Cpu,
        :cpu_bit_id => "value for cpu_bit_id",
        :cpu_family_id => "value for cpu_family_id",
        :manufacturer => manufacturer,
        :cpu_name_id => "value for cpu_name_id",
        :clock => "value for clock",
        :hardware => []
      ),
      stub_model(Cpu,
        :cpu_bit_id => "value for cpu_bit_id",
        :cpu_family_id => "value for cpu_family_id",
        :manufacturer => manufacturer,
        :cpu_name_id => "value for cpu_name_id",
        :clock => "value for clock",
        :hardware => []
        
      ), 
    ]
    assigns[:cpus].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_cpus" do
    render
    response.should have_tag("tr>td", "value for cpu_bit_id".to_s, 2)
    response.should have_tag("tr>td", "value for cpu_family_id".to_s, 2)
    response.should have_tag("tr>td", "Manufacturer", 2)
    response.should have_tag("tr>td", "value for cpu_name_id".to_s, 2)
    response.should have_tag("tr>td", "value for clock".to_s, 2)
  end
end
