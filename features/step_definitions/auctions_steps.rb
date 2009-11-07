Given /^the following auctions? exists?:$/ do |table|
  table.hashes.each do |fields|
    Factory(:auction,
      :title => fields[:title],
      :hardware => Factory(:hardware, :name => fields[:hardware]),
      :ebay_site => Factory(:ebay_site, :name => fields[:ebay_site])
    )
  end
end

Given /^the auction titled "([^\"]*)" has ended with (\d+) bids?$/ do |title, bids|
  auction = Auction.find_by_title(title)
  auction.update_attribute(:end_time, Time.now.ago(3.minutes))
  if bids == '0'
    mock_response = mock_model(EbayFinder::Request, :response => EbayFinder::GetItemStatusResponse.new(File.read("#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/GetItemStatusItemCompleted0Bids.xml")))
    EbayFinder::Request.should_receive(:new).and_return(mock_response)
  else
    mock_response = mock_model(EbayFinder::Request, :response => EbayFinder::GetItemStatusResponse.new(File.read("#{RAILS_ROOT}/vendor/plugins/ebay_finder/spec/stubs/GetItemStatusItemCompleted.xml")))
    EbayFinder::Request.should_receive(:new).and_return(mock_response)
  end
end

