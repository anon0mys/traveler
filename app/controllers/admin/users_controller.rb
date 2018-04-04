class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(:id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    @user.assign_attributes(user_params)
    if @user.save(validate: false)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
