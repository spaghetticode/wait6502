Given /^I have entered some data for storage names, formats and sizes$/ do
  ['floppy disk', 'tape', 'hard disk'].each do |name|
    StorageName.create!(:name => name)
  end
  ['5.25 inches', '3.5 inches', '8 inches'].each do |format|
    StorageFormat.create(:name => format)
  end
  %w{360Kb 720Kb 1.2Mb 1.44Mb}.each do |size|
    StorageSize.create!(:name => size)
  end
end

Given /^a builtin storage "([^\"]*)" exists$/ do |fields|
  name, format, size = fields.split('-')
  BuiltinStorage.create!(
    :storage_name_id => name,
    :storage_format_id => format,
    :storage_size_id => size
  )
end
