require 'spec_helper'

describe "/admin/images/index.html.haml" do
  include Admin::ImagesHelper

  before(:each) do
    assigns[:images] = [
      mock_model(Image,
        :title => 'title',
        :caption => 'caption',
        :picture => 'image.png'
      )
    ]
    assigns[:imageable] = mock_model(Hardware, :name => 'Computer name')
  end
  
  it 'render a list of images' do
    render
    response.should have_tag('h1', 'Computer name Images')
    response.should have_tag('tr>td', 'title')
    response.should have_tag('tr>td', 'caption')
  end
end