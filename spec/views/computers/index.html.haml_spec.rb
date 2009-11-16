require 'spec_helper'

describe "/computers/index" do
  before(:each) do
    assigns[:computers] = []
    render 'computers/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
