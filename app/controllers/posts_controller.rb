class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @user = current_user
    @post = @user.posts.new
    @location = Location.new
    @countries = Country.all
  end

  def create
    post = current_user.posts.new(build_params)
    if post.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    render file: '/public/404' unless @post.user.id == @user.id
    @location = @post.location
    @countries = Country.all
  end

  def update
    post = current_user.posts.find(params[:id])
    if post.update(build_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    if post.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, location: [:country, :lat, :lng])
  end

  def build_params
    all_params = post_params
    loc_data = all_params[:location]
    all_params[:location] = Location.find_by_lat_and_lng(loc_data[:lat], loc_data[:lng])
    unless all_params[:location]
      all_params[:location] = Location.create(loc_data)
    end
    all_params
  end
end
