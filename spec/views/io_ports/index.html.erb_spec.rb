require 'spec_helper'

describe "/io_ports/index" do
  before(:each) do
    assigns[:io_ports] = [stub_model(IoPort, :name => 'RS232', :hardware => [])]
    render 'io_ports/index'
  end

  it "should tell you where to find the file" do
    response.should have_tag('h2')
    response.should have_tag('a', assigns[:io_ports].first.name)
  end
end
