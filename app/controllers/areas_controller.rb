class AreasController < ApplicationController
  
  # GET /areas
  # Show areas on area map
  def index
    set_user_and_user_areas
    @page_title = if @user then "#{@user.login}'s areas" else "Areas" end
  end
  
   # GET /area/:id  
   # Get area data and show it on area map
   def show
     set_user_and_user_areas
     @searched_areas << Area.find(params[:area][:id])
     render :index
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
     @searched_areas = []
     @request = request
   end
end
