require 'spec_helper'

describe "/admin/ebay_keywords/index" do
  include Admin::EbayKeywordsHelper

  before(:each) do
    assigns[:searchable] = mock_model(Computer, :name => 'Computer Name')
    assigns[:ebay_keywords] = [mock_model(EbayKeyword,
      :name => 'kw name',
      :searchable => assigns[:searchable]
    )]
  end
  
  it 'should render a list of keywords' do
    render 'admin/ebay_keywords/index'
    response.should have_tag('h1')
    response.should have_tag('tr>td', 'kw name')
  end
end
