Given /^I uploaded an image titled "([^\"]*)" for "([^\"]*)" (hardware)$/ do |title, name, model|
  imageable = model.classify.constantize.find_by_name(name)
  visit send("admin_#{model}_images_path", imageable)
  click_link "New image"
  fill_in "Title", :with => title
  attach_file(:picture, "#{RAILS_ROOT}/spec/fixtures/rails.png", 'image/png')  
  click_button "Create"
  imageable.images.first.title.should == title
end

Given /^I attach a valid image$/ do
  attach_file(:picture, File.join(RAILS_ROOT, 'spec/fixtures/rails.png'), 'image/png')  
end