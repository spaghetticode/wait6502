require 'spec_helper'

describe "/hardware_types/show" do
  before(:each) do
    @hardware = stub_model(Hardware, :name => 'Amiga 1000')
    @hardware_type = stub_model(HardwareType, :hardware => [@hardware], :name => 'computer')
    assigns[:hardware_type] = @hardware_type
    render 'hardware_types/show'
  end

  it "should tell you where to find the file" do
    response.should have_tag('h2', @hardware_type.name)
    response.should have_tag('a', @hardware.name)
  end
end
