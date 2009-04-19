Factory.define :user do |f|
  f.sequence(:login) {|n| "person#{n}" }
  f.sequence(:email) {|n| "person#{n}@example.com" }
  f.password "password"
  f.password_confirmation "password"
end