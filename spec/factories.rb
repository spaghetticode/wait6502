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