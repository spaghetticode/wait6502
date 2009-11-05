require 'spec_helper'

describe "/admin/images/new.html.haml" do
  include Admin::ImagesHelper

  before(:each) do
    assigns[:image] = mock_model(Image, :uploaded_file => '', :title => '', :caption => '')
    assigns[:imageable] = mock_model(Hardware, :name => 'Hardware Name')
  end
  

  it 'renders new image form' do
    render
    response.should have_tag('h1', 'New Image for Hardware Name')
    response.should have_tag('form[action=?][method=post]', admin_imageable_images_path(assigns[:imageable])) do
      with_tag('input#image_title[name=?]', 'image[title]')
      with_tag('textarea#image_caption[name=?]', 'image[caption]')
    end
  end
end