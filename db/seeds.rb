=begin
puts "Destroying existing data..."
%w[users countries currencies manufacturers cpu_families cpu_names cpu_bits cpus
  builtin_languages co_cpu_types co_cpus co_cpu_names operative_systems storage_names
  storage_formats storage_sizes builtin_storages io_ports hardware_types ebay_sites
].each do |table|
  ActiveRecord::Migration.execute("delete from #{table}")
end
=end

puts 'Creating user admin@test.com'
password = 'secret'
User.create!(
  :email => 'admin@test.com',
  :password => password,
  :password_confirmation => password
)

def attach(name, directory)
  filename = "#{RAILS_ROOT}/public/images/#{directory}/#{name.parameterize}.png"
  attachment = ActionController::UploadedStringIO.new(File.read(filename))
  attachment.content_type = 'image/png'
  attachment.original_path = filename
  attachment
end

puts 'Creating countries'
[
  'Italy', 'USA', 'France', 'Germany', 'Spain', 
  'Japan', 'Great Britain', 'Holland','Canada',
  'Australia', 'Austria', 'Portugal'
].each do |name|  
  Country.create!(
    :name => name,
    :flag => attach(name, 'flags')
  )
end

puts 'Creating currencies'
%w{EUR USD GBP CAD AUD YEN ITL FRF DEM PTE ESP ATS NLG}.each do |currency|
  Currency.create!(:name => currency)
end

puts 'Creating manufacturers'
[['Intel', 'USA'], ['Motorola', 'USA'],['Atari', 'USA'], ['Apple Computers', 'USA'],
['Commodore', 'USA'], ['Sinclair', 'Great Britain'], ['Zilog', 'USA']].each do |arr|
  name, country = arr
  country = Country.find_by_name(country)
  Manufacturer.create!(
    :name => name,
    :country => country,
    :logo => attach(name, 'manufacturers')
    )
end

puts 'Creating CPU families'
%w{Z80 X86 65XX}.each do |family|
  CpuFamily.create!(:name => family)
end

puts 'Creating CPU names'
%w{ Z80 6502 68000}.each do |cpu|
  CpuName.create!(:name => cpu)
end

puts 'Creating CPU bits'
['8 bit', '4 bit', '16 bit', '32 bit', '4/8 bit', '8/16 bit', '16/32 bit'].each do |bit|
  CpuBit.create!(:name => bit)
end

puts 'Creating CPU'
Cpu.create!(
  :cpu_name => CpuName.first,
  :cpu_family => CpuFamily.first,
  :cpu_bit => CpuBit.first,
  :manufacturer => Manufacturer.last,
  :clock => '2Mhz'
)

puts 'Creating builtin languages'
['Amiga Basic', 'Applesoft Basic', 'Microsoft Basic', 'Basic'].each do |name|
  BuiltinLanguage.create!(:name => name)
end

puts 'Creating co-cpu types'
['math', 'I/O', 'sound', 'video', 'generic'].each do |name|
  CoCpuType.create!(:name => name)
end

puts 'Creating co-cpu names'
%w{8087 Paula Gary 68881}.each do |name|
  CoCpuName.create!(:name => name)
end

puts 'Creating Co-CPU'
CoCpu.create!(
  :co_cpu_type => CoCpuType.first,
  :co_cpu_name => CoCpuName.first,
  :manufacturer => Manufacturer.first
)

puts 'Creating OSes'
%w{MS-DOS AmigaDOS Pro-DOS GEOS GEM}.each do |name|
  OperativeSystem.create!(:name => name)
end

puts 'Creating storage names'
['floppy disk drive', 'tape drive', 'hard disk drive'].each do |name|
  StorageName.create!(:name => name)
end

puts 'Creating storage formats'
['5.25"','3.5"', '3"', '8"'].each do |name|
  StorageFormat.create!(:name => name)
end

puts 'Creating storage sizes'
%w{360Kb 880Kb 720Kb 180Kb 140Kb 1.2Mb 1.44Mb 5Mb 10Mb 20Mb}.each do |format|
  StorageSize.create!(:name => format)
end

puts 'Creating builtin storage'
BuiltinStorage.create!(
  :storage_name => StorageName.first,
  :storage_format => StorageFormat.first,
  :storage_size => StorageSize.first
)

puts 'Creating IO ports'
[['audio in', 'mini-jack'], ['audio out', 'mini-jack'], ['video out', 'DIN 6 pins'],
 ['disk drive', 'DIN 8 pins'], ['parallel port', 'centronics'], ['serial port', 'DB-9']].each do |port|
  IoPort.create!(:name => port[0], :connector => port[1])
end

puts 'Creating Hardware Types'
['Home Computer', 'Personal Computer', 'Portable Computer', 'Pocket Computer', 'Monitor', 'Printer', 'Keyboard', 'Mouse', 'External Floppy Disk Drive', 'External Hard Disk'].each do |name|
  HardwareType.create!(:name => name)
end
  
puts 'Creating ebay sites'
[['Germany', :DE, :EUR, 77], ['Italy', :IT, :EUR, 101], ['USA', :US, :USD, 1], ['France', :FR, :EUR, 71],
['Spain', :ES, :EUR, 186], ['Great Britain', :UK, :GBP, 3], ['Holland', :NL, :EUR, 146],
['Australia', :AU, :AUD, 15], ['Canada', :CA, :CAD, 2]].each do |country|
  name, code, currency, site_id = *country
  EbaySite.create!(
    :name => code.to_s,
    :site_id => site_id,
    :currency => Currency.find(currency.to_s),
    :country => Country.find_by_name(name)
  )
end
