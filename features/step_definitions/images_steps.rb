Given /^I uploaded an image titled "([^\"]*)" for "([^\"]*)" (computer|peripheral)$/ do |title, name, model|
  imageable = model.classify.constantize.find_by_name(name)
  visit send("admin_#{model}_images_path", imageable)
  click_link "New image"
  fill_in "Title", :with => title
  Given "I attach a valid image"
  click_button "Create"
  imageable.images.first.title.should == title
end

Given /^I attach a valid image$/ do
  attach_file('Image File', File.join(RAILS_ROOT, 'public/images/rails.png'), 'image/png')
end
  