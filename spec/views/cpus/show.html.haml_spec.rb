require 'spec_helper'

describe "/cpus/show" do
  before(:each) do
    assigns[:cpu] = mock_model(Cpu, :name => 'Z80').as_null_object
    render 'cpus/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
