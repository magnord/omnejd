require 'faker'

Sham.login { |n| "user#{n}" }
Sham.name { |n| Faker::Lorem.words(1).to_s + "#{n}" }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }
Sham.pos { |n| Point.from_x_y(n,n) }
Sham.geom {|n| Polygon.from_coordinates([[[n*5,n*5],[n*5,n*5+5],[n*5+5,n*5+5],[n*5+5,n*5],[n*5,n*5]]])}

User.blueprint do
  login
  email
  password "password"
  password_confirmation "password"
end

Post.blueprint do
  title
  body
  user
  pos 
end

Area.blueprint do
  name  
  geom 
end

