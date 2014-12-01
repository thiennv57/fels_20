class SessionsController < ApplicationController
  before_action :redirect_signed_in_user, except: [:destroy]
  
  def new
  end
  
  def create
    user = User.find_by_username params[:session][:username]
    if user && user.authenticate(params[:session][:password])
      sign_in user
      remember user
      flash[:success] = "You have signed in."
      redirect_back_or_to admin? ? admin_root_path : root_path
    else
      flash.now[:error] = "Wrong username or password!"
      render "new"
    end
  end
  
  def destroy
    sign_out if user_signed_in?
    flash[:success] = "You have signed out."
    redirect_to root_path
  end
end
