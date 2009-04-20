Factory.define :area do |f|
  f.sequence(:name) {|n| "area#{n}" }
  f.sequence(:geom) {|n| Polygon.from_points([[
    Point.from_x_y(n*5,n*5),
    Point.from_x_y(n*5,n*5+5),
    Point.from_x_y(n*5+5,n*5+5),
    Point.from_x_y(n*5+5,n*5),
    Point.from_x_y(n*5,n*5)]])}
end
