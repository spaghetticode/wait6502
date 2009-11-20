require 'spec_helper'

describe "/builtin_languages/show" do
  before(:each) do
    assigns[:builtin_language] = stub_model(BuiltinLanguage, :name => 'basic 1.0', :hardware => [])
    render 'builtin_languages/show'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
