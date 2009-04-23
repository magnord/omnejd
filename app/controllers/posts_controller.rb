class PostsController < ApplicationController

  before_filter :set_user_and_area, :init_map, :outline_area

  # GET /posts
  # GET /posts.xml
  def index
    @page_title = "Posts"
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

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

    respond_to do |format|
      if @post.update_attributes(params[:post])
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

  def outline_area
    if @area then
      polygon = @area.geom
      envelope = polygon.envelope
      area_outline = GPolygon.from_georuby(polygon,"#cc0000",2,0.8,"#aa2222",0.1)
      center = GLatLng.from_georuby(envelope.center)
      zoom = @map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))     
    else
      center = [58.9, 11.93]
      zoom = 8
    end
    @map.clear_overlays
    @map.center_zoom_init(center,zoom)
    @map.overlay_init(area_outline) if area_outline
  end
end
