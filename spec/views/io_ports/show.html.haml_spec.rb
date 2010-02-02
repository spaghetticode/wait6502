require 'spec_helper'

describe "/io_ports/show" do
  before(:each) do
    @hardware = stub_model(Hardware, :full_name => 'Commodore Amiga 2000', :name => 'Amiga 1000')
    hardware = [@hardware]
    hardware.stub!(:by_manufacturer => hardware)
    assigns[:io_port] = stub_model(IoPort, :name => 'RS232', :hardware => hardware)
    render 'io_ports/show'
  end

  it "should tell you where to find the file" do
    response.should have_tag('h2', /#{assigns[:io_port].name.capitalize}/)
    response.should have_tag('a', @hardware.full_name)
  end
end
