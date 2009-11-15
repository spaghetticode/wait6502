Factory.define :country do |c|
  c.sequence(:name) {|n| "country#{n}"}
end

Factory.define :user do |u|
  u.sequence(:email) {|n| "email#{n}@test.com"}
  u.password 'secret'
  u.password_confirmation 'secret'
end

Factory.define :currency do |c|
  c.sequence(:name) {|n| "USD#{n}"}
end

Factory.define :manufacturer do |m|
  m.sequence(:name) {|n| "name#{n}"}
  m.association :country
end

Factory.define :io_port do |io|
  io.sequence(:name) {|n| "port name#{n}"}
  io.connector 'centronics'
end

Factory.define :storage_name do |s|
  s.sequence(:name) {|n| "name #{n}"}
end

Factory.define :storage_format do |s|
  s.sequence(:name) {|n| "format #{n}"}
end

Factory.define :storage_size do |s|
  s.sequence(:name) {|n| "size #{n}"}
end

Factory.define :builtin_storage do |bs|
  bs.association :storage_name
  bs.association :storage_format
  bs.association :storage_size
end

Factory.define :cpu_family do |cf|
  cf.sequence(:name) {|n| "family #{n}"}
end

Factory.define :cpu_name do |cn|
  cn.sequence(:name) {|n| "name #{n}"}
end

Factory.define :cpu_bit do |cn|
  cn.sequence(:name) {|n| "#{n} bit"}
end

Factory.define :cpu do |c|
  c.association :cpu_bit
  c.association :cpu_name
  c.association :manufacturer
  c.association :cpu_family
  c.sequence(:clock){|n| "#{n}Mhz"}
end

Factory.define :operative_system do |os|
  os.sequence(:name) {|n| "os #{n}"}
end

Factory.define :builtin_language do |l|
  l.sequence(:name) {|n| "language #{n}"}
end

Factory.define :co_cpu_type do |cc|
  cc.sequence(:name) {|n| "math #{n}"}
end

Factory.define :co_cpu_name do |cc|
  cc.sequence(:name) {|n| "co cpu #{n}"}
end

Factory.define :co_cpu do |cc|
  cc.association :co_cpu_name
  cc.association :co_cpu_type
  cc.association :manufacturer
end

Factory.define :hardware do |h|
  h.sequence(:name) {|n| "hardware #{n}"}
  h.association :hardware_type
  h.association :manufacturer
  h.association :hardware_type
  h.hardware_category Hardware::CATEGORIES.first
end

Factory.define :original_price do |op|
  op.association :currency
  op.association :country
  op.date Date.today
  op.amount 999.99
  op.association :purchaseable, :factory => :hardware
end

Factory.define :image do |i|
  i.association :imageable, :factory => :hardware
  i.title 'Image Title'
  i.caption 'Image Caption'
  # missing uploaded_file attribute which must be stubbed
end

Factory.define :hardware_type do |ht|
  ht.sequence(:name) {|n| "hardware_type #{n}"}
end

Factory.define :ebay_site do |es|
  es.sequence(:name) {|n| "name #{n}"}
  es.association :currency
  es.association :country
end

Factory.define :auction do |a|
  a.association :currency
  a.association :hardware
  a.association :ebay_site
  a.title 'Auction title'
  a.cosmetic_conditions 'average'
  a.completeness 'complete'
  a.sequence(:url) {|n| "http://some.ebay.com/url-name-#{n}"}
  a.end_time Time.now.tomorrow
  a.sequence(:item_id) {|n| "12345#{n}"}
end