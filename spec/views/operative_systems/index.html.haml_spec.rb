require 'spec_helper'

describe "/operative_systems/index" do
  before(:each) do
    assigns[:operative_systems] = []
    render 'operative_systems/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
