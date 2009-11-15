require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/manufacturers/index.html.haml" do

  before(:each) do
    country = stub_model(Country, :flag_image_filename => '', :name => 'USA')
    assigns[:manufacturers] = [
      stub_model(Manufacturer,
        :name => "Apple",
        :country => country
      ),
      stub_model(Manufacturer,
        :name => "Olivetti",
        :country => country
      )
    ]
    assigns[:manufacturers].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_manufacturers" do
    render
    response.should have_tag("tr>td", "Apple".to_s, 2)
  end
end
