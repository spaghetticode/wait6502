require 'spec_helper'

describe "/operative_systems/show" do
  before(:each) do
    hardware = []
    hardware.stub!(:by_manufacturer => [])
    assigns[:operative_system] = stub_model(OperativeSystem, :name => 'MS DOS', :hardware => hardware)
    render 'operative_systems/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('h2', assigns[:operative_system].name)
  end
end
