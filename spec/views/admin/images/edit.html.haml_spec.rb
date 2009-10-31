require 'spec_helper'

describe "/admin/images/edit.html.haml" do
  include Admin::ImagesHelper

  before(:each) do
    assigns[:imageable] = mock_model(Computer, :name => 'Computer Name')
    assigns[:image] = mock_model(Image,
      :uploaded_file => '',
      :title => 'Title',
      :caption => 'Caption'
    )
  end
  
  it 'should render an edit form' do
    render
    response.should have_tag("form[action=#{admin_computer_image_path(assigns[:imageable], assigns[:image])}][method=post]") do
      with_tag('input#image_title[name=?]', 'image[title]')
      with_tag('textarea#image_caption[name=?]', 'image[caption]')
    end
  end
end