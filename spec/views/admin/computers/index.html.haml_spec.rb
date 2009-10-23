require 'spec_helper'

describe "/admin/computers/index.html.haml" do
  include Admin::ComputersHelper

  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'Apple')
    assigns[:computers] = [
      stub_model(Computer,
        :name => "value for name",
        :manufacturer => manufacturer,
        :computer_type_id => "value for com_type_id",
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
        :sound => "value for sound"
      ),
      stub_model(Computer,
        :name => "value for name",
        :manufacturer => manufacturer,
        :computer_type_id => "value for com_type_id",
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
        :sound => "value for sound"
      )
    ]
    assigns[:computers].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_computers" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for com_type_id".to_s, 2)
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
