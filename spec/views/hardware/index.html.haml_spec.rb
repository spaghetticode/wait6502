require 'spec_helper'

describe "/hardware/index" do
  before(:each) do
    assigns[:computers] = []
    assigns[:peripherals] = []
    render 'hardware/index'
  end

  it "should succeed" do
    response.should be_true
  end
end
