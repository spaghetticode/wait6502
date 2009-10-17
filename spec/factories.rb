Factory.define :country do |c|
  c.sequence(:name) {|n| "country#{n}"}
end

Factory.define :user do |u|
  u.sequence(:email) {|n| "email#{n}@test.com"}
  u.password 'secret'
  u.password_confirmation 'secret'
end