Given /^I have entered some data for storage names, formats and sizes$/ do
  ['floppy disk', 'tape', 'hard disk'].each do |name|
    StorageName.create!(:name => name)
  end
  ['5.25"', '3.5"', '8"'].each do |format|
    StorageFormat.create(:name => format)
  end
  %w{360Kb 720Kb 1.2Mb 1.44Mb}.each do |size|
    StorageSize.create!(:name => size)
  end
end
