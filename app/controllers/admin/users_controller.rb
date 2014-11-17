class Admin::UsersController < ApplicationController
  before_action :admin_auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.search(params[:name]).paginate page: params[:page], per_page: 20
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_param
    if @user.save
      flash[:success] = "You have successfully signed up!"
      redirect_to admin_users_path
    else
      render "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update user_param
      flash[:success] = "Profile has been successfully updated!"
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "A user has been deleted."
    redirect_to admin_users_path
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def user_param
      params.require(:user).permit(:username, :email,
                    :password, :password_confirmation,
                    :avatar)
    end
end
