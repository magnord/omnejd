Factory.define :area do |f|
  f.sequence(:name) {|n| "area#{n}" }
  f.sequence(:geom) {|n| Polygon.from_coordinates([[[n*5,n*5],[n*5,n*5+5],[n*5+5,n*5+5],[n*5+5,n*5],[n*5,n*5]]])}
end
