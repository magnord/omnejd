Factory.define :post do |f|
  f.title "Something's going on in Area 51"
  f.body "Look! It's a..."
  f.user {|a| a.association(:user) }
  f.pos Point.from_x_y(2,2)
end

Factory.define :post_in, :class => Post do |f|
  f.title "Inside Area 51"
  f.body "I'm inside!"
  f.user {|a| a.association(:user) }
  f.pos Point.from_x_y(1,2)
end

Factory.define :post_out, :class => Post do |f|
  f.title "Outside Area 51"
  f.body "I'm outside!"
  f.user {|a| a.association(:user) }
  f.pos Point.from_x_y(7,7)
end