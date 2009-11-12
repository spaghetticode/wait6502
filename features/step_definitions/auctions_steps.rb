Given /^the following auctions? exists?:$/ do |table|
  table.hashes.each do |fields|
    Factory(:auction,
      :title => fields[:title],
      :hardware => Factory(:hardware, :name => fields[:hardware]),
      :ebay_site => EbaySite.find_by_name(fields[:ebay_site]) || Factory(:ebay_site, :name => fields[:ebay_site])
    )
  end
end

Given /^the following ebay sites? exists?:$/ do |table|
  table.hashes.each do |site|
    Factory(:ebay_site, :name => site[:name])
  end
end

Given /^the auction titled "([^\"]*)" has ended with (\d+) bids?$/ do |title, bids|
  auction = Auction.find_by_title(title)
  auction.update_attribute(:end_time, Time.now.ago(3.minutes))
  filename = bids == '0' ? 'GetItemStatusItemCompleted0Bids.xml' : 'GetItemStatusItemCompleted.xml'
  mock_response(filename, EbayFinder::GetItemStatusResponse)
end

Given /^I stub search requests to ebay$/ do
  filename = 'FindItemsAdvancedResponse1Item.xml'
  mock_response(filename, EbayFinder::FindItemsAdvancedResponse)
end

Given /^I stub image downloads from ebay$/ do
  filename = "#{RAILS_ROOT}/public/images/rails.png"
  mock_response = mock(:class => Net::HTTPOK, :body => File.read(filename))
  mock_request = mock(:class => Net::HTTP, :get => mock_response, :read_timeout= => nil)
  Net::HTTP.stub!(:new => mock_request)
end

Given /^the auction titled "([^\"]*)" is closed$/ do |title|
  Auction.find_by_title(title).update_attribute(:end_time, Time.now.yesterday)
end

private

def mock_response(filename, klass)
  mock_xml = File.read("#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/#{filename}")
  mock_response = mock(:class => EbayFinder::Request, :response => klass.new(mock_xml))
  EbayFinder::Request.should_receive(:new).and_return(mock_response)
end
