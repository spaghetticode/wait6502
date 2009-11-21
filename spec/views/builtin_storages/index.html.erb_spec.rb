require 'spec_helper'

describe "/builtin_storages/index" do
  before(:each) do
    assigns[:storages] = []
    render 'builtin_storages/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
