require 'spec_helper'

describe "/io_ports/show" do
  before(:each) do
    @hardware = stub_model(Hardware, :name => 'Amiga 2000')
    assigns[:io_port] = stub_model(IoPort, :name => 'RS232', :hardware => [@hardware])
    render 'io_ports/show'
  end

  it "should tell you where to find the file" do
    response.should have_tag('h2', /#{assigns[:io_port].name.capitalize}/)
    response.should have_tag('a', @hardware.name)
  end
end
