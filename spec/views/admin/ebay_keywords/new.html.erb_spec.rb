require 'spec_helper'

describe "/admin/ebay_keywords/new" do
  include Admin::EbayKeywordsHelper
  
  before(:each) do
    assigns[:searchable] = mock_model(Peripheral, :name => 'Peripheral Name')
    assigns[:ebay_keyword] = mock_model(EbayKeyword,
      :name => '',
      :searchable => assigns[:searchable])
  end
  
  it 'should render new tempalte' do
    render
    response.should have_tag('h1')
    response.should have_tag('form[action=?][method=post]', admin_searchable_ebay_keywords_path(assigns[:searchable])) do
      with_tag('input#ebay_keyword_name[name=?]', 'ebay_keyword[name]')
    end
  end
end
