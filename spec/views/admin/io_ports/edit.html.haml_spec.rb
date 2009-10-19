require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/io_ports/edit.html.haml" do
  include Admin::IoPortsHelper

  before(:each) do
    assigns[:io_port] = @io_port = stub_model(IoPort,
      :new_record? => false,
      :name => "value for name",
      :connector => "value for connector"
    )
  end

  it "renders the edit io_port form" do
    render

    response.should have_tag("form[action=#{admin_io_port_path(@io_port)}][method=post]") do
      with_tag('input#io_port_name[name=?]', "io_port[name]")
      with_tag('input#io_port_connector[name=?]', "io_port[connector]")
    end
  end
end
