Given /^the following auctions? exists?:$/ do |table|
  table.hashes.each do |fields|
    Factory(:auction,
      :title => fields[:title],
      :hardware => Factory(:hardware, :name => fields[:hardware]),
      :ebay_site => Factory(:ebay_site, :name => fields[:ebay_site])
    )
  end
end
