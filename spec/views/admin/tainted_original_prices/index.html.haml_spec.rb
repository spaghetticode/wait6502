require 'spec_helper'

describe "/admin/tainted_original_prices/index" do
  before(:each) do
    assigns[:tainted_prices] = []
    render 'admin/tainted_original_prices/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
