Given /^I created a keyword "([^\"]*)" for "([^\"]*)" (hardware)$/ do |kw_name, hw_name, model|
  searchable = model.classify.constantize.find_by_name(hw_name)
  keyword = Factory(:ebay_keyword, :name => kw_name, :searchable => searchable)
  searchable.ebay_keywords.should include(keyword)
end

