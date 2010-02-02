require 'spec_helper'

describe "/builtin_storages/show" do
  before(:each) do
    hardware = []
    hardware.stub!(:by_manufacturer => [])
    assigns[:storage] = mock_model(BuiltinStorage, :full_name => 'tape recorder', :hardware => hardware)
    render 'builtin_storages/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
