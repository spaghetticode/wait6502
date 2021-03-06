require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/io_ports/index.html.haml" do

  before(:each) do
    assigns[:io_ports] = [
      stub_model(IoPort,
        :name => "value for name",
        :connector => "value for connector"
      ),
      stub_model(IoPort,
        :name => "value for name",
        :connector => "value for connector"
      )
    ]
    assigns[:io_ports].stub!(:total_pages).and_return(0)
  end

  it "renders a list of io_ports" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for connector".to_s, 2)
  end
end
