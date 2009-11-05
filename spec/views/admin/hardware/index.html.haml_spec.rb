require 'spec_helper'

describe "/admin/hardware/index.html.haml" do

  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'Apple')
    assigns[:hardware] = [
      stub_model(Hardware,
        :name => "value for name",
        :manufacturer => manufacturer,
        :hardware_type_id => "value for hardware_type_id",
        :code => "value for code",
        :codename => "value for codename",
        :ram => "value for ram",
        :vram => "value for vram",
        :rom => "value for rom",
        :production_start => 1988,
        :production_stop => 1989,
        :builtin_language_id => "value for builtin_language_id",
        :text_modes => "value for text_modes",
        :graphic_modes => "value for graphic_modes",
        :sound => "value for sound",
        :cpu_names => 'cpu names',
        :co_cpu_names => 'co cpu names',
        :io_port_names => 'io port names',
        :storage_names => 'storage names',
        :os_names => 'os names'
      ),
      stub_model(Hardware,
        :name => "value for name",
        :manufacturer => manufacturer,
        :hardware_type_id => "value for hardware_type_id",
        :code => "value for code",
        :codename => "value for codename",
        :ram => "value for ram",
        :vram => "value for vram",
        :rom => "value for rom",
        :production_start => "value for production_start",
        :production_stop => 1,
        :builtin_language_id => "value for builtin_language_id",
        :text_modes => "value for text_modes",
        :graphic_modes => "value for graphic_modes",
        :sound => "value for sound",
        :cpu_names => 'cpu names',
        :co_cpu_names => 'co cpu names',
        :io_port_names => 'io port names',
        :storage_names => 'storage names',
        :os_names => 'os names'
      )
    ]
    assigns[:hardware].stub!(:total_pages).and_return(0)
  end

  it "renders a list of hardware items" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for hardware_type_id".to_s, 2)
    response.should have_tag("tr>td", "value for code".to_s, 2)
    response.should have_tag("tr>td", "value for codename".to_s, 2)
    response.should have_tag("tr>td", "value for ram".to_s, 2)
    response.should have_tag("tr>td", "value for vram".to_s, 2)
    response.should have_tag("tr>td", "value for rom".to_s, 2)
    response.should have_tag("tr>td", "1989".to_s, 2)
    response.should have_tag("tr>td", "Apple", 2)
    response.should have_tag("tr>td", "value for builtin_language_id".to_s, 2)
    response.should have_tag("tr>td", "value for text_modes".to_s, 2)
    response.should have_tag("tr>td", "value for graphic_modes".to_s, 2)
    response.should have_tag("tr>td", "value for sound".to_s, 2)
  end
end
