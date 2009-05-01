class PostsController < ApplicationController

  before_filter :set_user_and_user_areas, :init_map

  # GET /posts
  # GET /posts.xml
  def index
    outline_areas(@map, @areas)
    @page_title = "Posts"
    @posts = find_areas_posts
    @posts.each do |post|
      add_post_marker(@map, post)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    outline_areas(@map, @areas)
    @post = Post.find(params[:id])
    add_post_marker(@map, @post)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    outline_areas(@map, @areas, false)
    create_draggable_marker(@map)
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    outline_areas(@map, @areas, false)
    @post = Post.find(params[:id])
    create_draggable_marker_for_edit(@map, @post)
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new params[:post]
    @post.user = @user
    @post.pos = Point.from_x_y(params[:lng], params[:lat])
  
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
    @post.attributes = params[:post]
    @post.pos = Point.from_x_y(params[:lng], params[:lat])
    
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
  def set_user_and_user_areas
     @user = current_user
     # This is probably very ineffiecient
     @areas = if @user then @user.areas else [] end
   end

  def init_map
    @map = GMap.new("map_div")
    @map.control_init(:small_map => true, :map_type => true)
  end
  
  def find_areas_posts
    posts = []
    for area in @areas do
      posts.concat area.find_contained_posts
    end
    return posts.uniq
  end

end
