require 'spec_helper'

describe "/admin/images/index.html.haml" do
  include Admin::ImagesHelper

  before(:each) do
    assigns[:images] = [
      mock_model(Image,
        :uploaded_file => 'file',
        :original_filename => 'filename',
        :title => 'title',
        :caption => 'caption'
      )
    ]
    assigns[:imageable] = mock_model(Computer, :name => 'Computer name')
  end
  
  it 'render a list of images' do
    render
    response.should have_tag('h1', 'Listing Images for Computer name')
    response.should have_tag('tr>td', 'title')
    response.should have_tag('tr>td', 'caption')
  end
end