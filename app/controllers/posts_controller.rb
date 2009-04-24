class PostsController < ApplicationController

  before_filter :set_user_and_area, :init_map

  # GET /posts
  # GET /posts.xml
  def index
    outline_area
    @page_title = "Posts"
    @posts = Post.all
    @posts.each do |post|
      add_post_marker(post)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    outline_area
    @post = Post.find(params[:id])
    add_post_marker(@post)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    outline_area(false)
    create_draggable_marker
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    outline_area(false)
    @post = Post.find(params[:id])
    create_draggable_marker_for_edit
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new_from_latlng_params_and_user(params, @user)
  
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @post.update_attributes_from_latlng_params_and_user(params, @user)
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  private
  def set_user_and_area
    @user = current_user
    @area = @user && @user.areas.length > 0 && @user.areas.first
  end

  def init_map
    @map = GMap.new("map_div")
    @map.control_init(:small_map => true, :map_type => true)
  end

  # Outline the current watched area (first center and zoom the map to suit the extent of the area)
  def outline_area(draw = true)
    if @area then
      polygon = @area.geom
      envelope = polygon.envelope
      area_outline = GPolygon.from_georuby(polygon,"#cc0000",2,0.8,"#aa2222",0.1)
      center = GLatLng.from_georuby(envelope.center)
      zoom = @map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))     
    else
      # No user logged in, center on arbitrary location (shoudl use goelocation on IP).
      center = [58.9, 11.93]
      zoom = 8
    end
    @map.clear_overlays
    @map.center_zoom_init(center,zoom)
    @map.overlay_init(area_outline) if area_outline and draw
  end
  
  def add_post_marker(post)
    @map.overlay_init(GMarker.new([post.pos.y, post.pos.x],
    :title => post.title,:info_window => post.body)) # TODO: Add maxWidth for info_window
  end
  
  # Create a new draggable marker to define the postion of a new post
  def create_draggable_marker
    @map.record_init('create_draggable_marker();')
  end
  
  # Create a draggable marker to edit the postion of a post
  def create_draggable_marker_for_edit
    @map.record_init("create_draggable_marker_for_edit(#{@post.pos.x},#{@post.pos.y});")
  end
end
