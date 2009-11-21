require 'spec_helper'

describe "/computers/show" do
  before(:each) do
    assigns[:computer] = mock_model(Hardware, :name => 'Apple IIc').as_null_object
    render 'computers/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
