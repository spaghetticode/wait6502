require 'spec_helper'

describe "/admin/tainted_original_prices/edit" do
  before(:each) do
    assigns[:tainted_price] = mock_model(OriginalPrice, :date => Date.today).as_null_object
    render 'admin/tainted_original_prices/edit'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
