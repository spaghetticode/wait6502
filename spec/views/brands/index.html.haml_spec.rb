require 'spec_helper'

describe "/brands/index" do
  before(:each) do
    assigns[:brands] = []
    render 'brands/index'
  end


  it "should tell you where to find the file" do
  end
end
