require 'spec_helper'

describe "/peripherals/index" do
  before(:each) do
    assigns[:peripherals] = []
    render 'peripherals/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
