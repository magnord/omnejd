class AreasController < ApplicationController
  
  #before_filter :set_user_and_user_areas, :init_map
  
  # GET /areas
  def index
    set_user_and_user_areas
    init_map
    @page_title = if @user then "#{@user.login}'s areas" else "Areas" end
    
    add_map_event_find_areas(@map) # Will ajax-call areas/find
    set_center_and_zoom_for_user_areas(@map, @user_areas)
  end
  
   def show
     @area = Area.find(params[:id])
     puts "***************************" + @area.to_json
   end
  
  
  # Find areas by bounding box. Called (Ajax) by map move event.
  def find
    set_user_and_user_areas
    @areas = Area.find_all_by_geom([[params[:min_y], params[:min_x]], 
                               [params[:max_y], params[:max_x]]])
    @map = Variable.new("map")
  end
  
  # Find areas by name. Called (Ajax) by autocompleting text field.
  def search
    @areas = Area.all(
      :select => "id, name", 
      :conditions => ["name ILIKE ?", params[:q]+'%'], # Postgres case insensitive matching
      :order => "name", 
      :limit => params[:limit])
    render :text => @areas.map { |area| area.name + "|#{area.id}" }.join("\n")
  end

  private
   def set_user_and_user_areas
     @user = current_user
     # This is probably very ineffiecient
     @watched_areas = if @user then @user.watched_areas else [] end
     @user_areas = if @user then @user.areas else [] end
   end

   def init_map
     @map = GMap.new("map_div")
     @map.control_init(:large_map => true, :map_type => true)
   end
end
