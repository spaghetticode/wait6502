require 'spec_helper'

describe "/admin/auctions/index.html.haml" do

  before(:each) do
    hardware = mock_model(Hardware, :name => 'Amiga 1000')
    assigns[:auctions] = [
      stub_model(Auction,
        :hardware => hardware,
        :ebay_site_id => 1,
        :currency_id => 1,
        :title => "value for title",
        :url => "value for url",
        :image_url => 'image url',
        :cosmetic_conditions => "value for cosmetic_conditions",
        :completeness => "value for completeness",
        :price_value => 9.99,
        :end_time => Time.now
      ),
      stub_model(Auction,
        :hardware => hardware,
        :ebay_site_id => 1,
        :currency_id => 1,
        :title => "value for title",
        :url => "value for url",
        :image_url => 'image url',
        :cosmetic_conditions => "value for cosmetic_conditions",
        :completeness => "value for completeness",
        :price_value => 9.99,
        :end_time => Time.now
      )
    ]
    assigns[:auctions].stub!(:total_pages).and_return(0)
  end

  it "renders a list of admin_auctions" do
    render
=begin    
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for cosmetic_conditions".to_s, 2)
    response.should have_tag("tr>td", "value for completeness".to_s, 2)
    response.should have_tag("tr>td", 9.99.to_s, 2)
=end
    response.should have_tag("form[action=?][method=post]", admin_resultset_path)
  end
end
