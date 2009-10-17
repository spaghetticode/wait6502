Factory.define :country do |c|
  c.sequence(:name) {|n| "country#{n}"}
end