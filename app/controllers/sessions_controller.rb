class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by_email(params[:email])
    if user &.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
