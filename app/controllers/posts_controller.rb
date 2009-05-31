class PostsController < ApplicationController

  before_filter :set_user_and_user_areas
  
  # GET /posts
  def index
    @page_title = "Posts"
    @posts = find_areas_posts unless @areas.blank? 
  end
  
  # Called (Ajax) on map change event
  # Find all posts within current bounding box
  def find
    @posts = Post.find_all_by_pos([[params[:min_y], params[:min_x]], 
                               [params[:max_y], params[:max_x]]], :order => "created_at DESC")
    @map = Variable.new("map") # YM4R JS-to-Ruby variable mapping
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    # TODO Check that a user session is present
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    # TODO Check that a user session is present
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    @post = Post.new params[:post]
    @post.user = @user
    @post.pos = Point.from_x_y(params[:lng], params[:lat])
  
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        redirect_to(@post)
      else
        render :action => "new"
    end
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])
    @post.attributes = params[:post]
    @post.pos = Point.from_x_y(params[:lng], params[:lat])

      if @post.save
        flash[:notice] = 'Post was successfully updated.'
        redirect_to(@post)
      else
        render :action => "edit"
      end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to(posts_url)
  end

  private
  def set_user_and_user_areas
     @user = current_user
     # This is probably very ineffiecient
     @areas = if @user then @user.areas else [] end
   end
  
  # Concatenate results from watched areas and sort, newest post first
  def find_areas_posts
    posts = []
    for area in @areas do
      posts.concat area.find_contained_posts
    end
    return posts.uniq.sort {|b,a| a.created_at <=> b.created_at}
  end

end
