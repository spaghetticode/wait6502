Factory.define :country do |c|
  c.sequence(:name) {|n| "country#{n}"}
end

Factory.define :user do |u|
  u.sequence(:email) {|n| "email#{n}@test.com"}
  u.password 'secret'
  u.password_confirmation 'secret'
end

Factory.define :currency do |c|
  c.sequence(:code) {|n| "code#{n}"}
  c.symbol '$'
end

Factory.define :manufacturer do |m|
  m.sequence(:name) {|n| "name#{n}"}
  m.association :country
end

Factory.define :computer_type do |c|
  c.sequence(:name) {|n| "comp_type#{n}"}
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
  cf.sequence(:name) {|n| "name #{n}"}
end