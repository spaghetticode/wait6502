require 'spec_helper'

describe "/co_cpus/show" do
  before(:each) do
    render 'co_cpus/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/co_cpus/show])
  end
end
