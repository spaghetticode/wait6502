require 'spec_helper'

describe "/manufacturers/index" do
  before(:each) do
    assigns[:manufacturers] = []
    render 'manufacturers/index'
  end


  it "should tell you where to find the file" do
  end
end
