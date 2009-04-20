Factory.define :post do |f|
  f.sequence(:title) { |n| "Title #{n}" }
  f.sequence(:body) { |n| "Body #{n}" }
  f.user {|a| a.association(:user) }
  f.sequence(:pos) { |n| Point.from_x_y(n,n) }
end