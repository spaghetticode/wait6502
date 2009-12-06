When /^I should see the search form$/ do
  response.should have_tag('div#search')
  response.should have_tag('form[method=get]')
  response.should have_tag('input#query[type=text]')
  response.should have_tag('input[type=submit]')
end