class AreasController < ApplicationController
  
  before_filter :set_user_and_user_areas, :init_map
  
  # GET /areas
  # GET /areas.xml
  def index
    @page_title = if @user then "#{@user.login}'s areas" else "Areas" end
    
    add_map_event_find_areas(@map) # Will ajax-call areas/find
    set_center_and_zoom_for_user_areas(@map, @user_areas)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @areas }
    end
  end
  
  # Called (Ajax) by map event
  def find
    @areas = Area.find_all_by_geom([[params[:min_y], params[:min_x]], 
                               [params[:max_y], params[:max_x]]])
    @map = Variable.new("map")
  end


  # GET /areas/1
  # GET /areas/1.xml
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.xml
  def new
    @area = Area.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.xml
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        flash[:notice] = 'Area was successfully created.'
        format.html { redirect_to(@area) }
        format.xml  { render :xml => @area, :status => :created, :location => @area }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.xml
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        flash[:notice] = 'Area was successfully updated.'
        format.html { redirect_to(@area) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.xml
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to(areas_url) }
      format.xml  { head :ok }
    end
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
