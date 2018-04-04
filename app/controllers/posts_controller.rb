class PostsController < ApplicationController
  def new
    @user = current_user
    @post = @user.posts.new
    @location = Location.new
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
    @post = current_user.posts.find(params[:id])
    @location = @post.location
  end

  def update
    post = current_user.posts.find(params[:id])
    if post.update(build_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, location: [:state, :country])
  end

  def build_params
    all_params = post_params
    loc_data = all_params[:location]
    all_params[:location] = Location.find_by_country_and_state(loc_data[:country], loc_data[:state])
    unless all_params[:location]
      all_params[:location] = Location.create(loc_data)
    end
    all_params
  end
end
