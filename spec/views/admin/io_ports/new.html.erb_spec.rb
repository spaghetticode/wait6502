require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/io_ports/new.html.erb" do
  include Admin::IoPortsHelper

  before(:each) do
    assigns[:io_port] = stub_model(IoPort,
      :new_record? => true,
      :name => "value for name",
      :connector => "value for connector"
    )
  end

  it "renders new io_port form" do
    render

    response.should have_tag("form[action=?][method=post]", io_ports_path) do
      with_tag("input#io_port_name[name=?]", "io_port[name]")
      with_tag("input#io_port_connector[name=?]", "io_port[connector]")
    end
  end
end
