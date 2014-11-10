class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_auth, except: [:new, :create]
  before_action :current_user_auth, only: [:show, :edit, :update]
  before_action :admin_auth, only: [:index, :destroy]
  before_action :redirect_signed_in_user, only: [:new, :create]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_param
    if @user.save
      flash[:success] = "You have successfully signed up!"
      session[:user_id] = @user.id # sign in user
      redirect_to @user
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
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    @user.destroy
    redirect_to users_path
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
    
    def current_user_auth
      unless current_user?(params[:id]) || current_user.admin?
        flash[:error] = "Permission denied!"
        redirect_to root_path
      end
    end
end
