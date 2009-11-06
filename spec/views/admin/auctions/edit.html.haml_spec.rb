require 'spec_helper'

describe "/admin/auctions/edit.html.haml" do

  before(:each) do
    assigns[:auction] = @auction = stub_model(Auction,
      :new_record? => false,
      :hardware_id => 1,
      :ebay_site_id => 1,
      :currency_id => 1,
      :title => "value for title",
      :url => "value for url",
      :cosmetic_conditions => "value for cosmetic_conditions",
      :completeness => "value for completeness",
      :price_value => 9.99,
      :end_time => Time.now
    )
  end

  it "renders the edit auction form" do
    render
=begin
    response.should have_tag("form[action=#{auction_path(@auction)}][method=post]") do
      with_tag('input#auction_hardware_id[name=?]', "auction[hardware_id]")
      with_tag('input#auction_ebay_site_id[name=?]', "auction[ebay_site_id]")
      with_tag('input#auction_currency_id[name=?]', "auction[currency_id]")
      with_tag('input#auction_title[name=?]', "auction[title]")
      with_tag('input#auction_url[name=?]', "auction[url]")
      with_tag('input#auction_cosmetic_conditions[name=?]', "auction[cosmetic_conditions]")
      with_tag('input#auction_completeness[name=?]', "auction[completeness]")
      with_tag('input#auction_price_value[name=?]', "auction[price_value]")
    end
=end
  end
end
