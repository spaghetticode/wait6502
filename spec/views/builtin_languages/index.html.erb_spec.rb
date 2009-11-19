require 'spec_helper'

describe "/builtin_languages/index" do
  before(:each) do
    language = stub_model(BuiltinLanguage, :name => 'basic 1.1')
    assigns[:builtin_languages] = [language]
    render 'builtin_languages/index'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
  end
end
