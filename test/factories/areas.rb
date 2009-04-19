Factory.define :area do |f|
  f.name "Area 51"
  f.geom Polygon.from_points([[Point.from_x_y(0,0),
      Point.from_x_y(0,5),Point.from_x_y(5,5),Point.from_x_y(5,0),Point.from_x_y(0,0)]])
end
