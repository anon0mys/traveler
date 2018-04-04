class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Thank you for creating an account!'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'Your account was not created, please try again.'
      render action: 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_home = current_user == @user
    @posts = @user.posts
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
