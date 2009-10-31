require 'spec_helper'

describe Image do
  before(:each) do
    @valid_attributes = {
      :original_filename => "value for original_filename"
    }
  end

  it "should create a new instance given valid attributes" do
    Image.create!(@valid_attributes)
  end
end
