require 'spec_helper'

describe "/co_cpus/index" do
  before(:each) do
    assigns[:co_cpus] = []
    render 'co_cpus/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('h2')
  end
end
