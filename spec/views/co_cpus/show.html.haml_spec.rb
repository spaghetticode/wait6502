require 'spec_helper'

describe "/co_cpus/show" do
  before(:each) do
    manufacturer = stub_model(Manufacturer, :name => 'CSG')
    assigns[:co_cpu] = stub_model(CoCpu, :name => 'Paula', :hardware => [], :manufacturer => manufacturer)
    render 'co_cpus/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p')
  end
end
