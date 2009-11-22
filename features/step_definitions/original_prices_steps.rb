Then /^the original price is now approved$/ do
  OriginalPrice.first.should_not be_tainted
end

Given /^the following original prices? exists?:$/ do |table|
  table.hashes.each do |price|
    hardware = Factory(:hardware, :name => price[:hardware])
    country = Factory(:country, :name => price[:country])
    currency = Factory(:currency, :name => price[:currency])
    hardware.original_prices.create!(
      :currency => currency,
      :country => country,
      :amount => price[:amount],
      :tainted => price[:tainted],
      :date => Date.parse("#{price[:year]}-10-12")
    )
  end
end

