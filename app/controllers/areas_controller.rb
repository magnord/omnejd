class AreasController < ApplicationController
  def show
     @page_title = "Sweden 5-Zip Sample"
     @map = GMap.new("map_div")

     @map.control_init(:large_map => true, :map_type => true)

     @map.center_zoom_init([58.9, 11.93],8)
   end
   
   def find
     areas = Sweden5.find(:all, :conditions => ["name = ?", params[:name]])

     if areas.empty?
       @message = "#{params[:name]} not in database"
     else
       @map = Variable.new("map")
       @polygons = []
       for area in areas do
         poly = area.geom[0]
         envelope = poly.envelope

         @id = area.id

         @polygons << GPolygon.from_georuby(poly,"#000000",2,0.8,"#ff5555",0.2)
         @center = GLatLng.from_georuby(envelope.center)
         @zoom = @map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))
       end
     end
   end
   
end
