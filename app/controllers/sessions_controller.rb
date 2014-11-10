class SessionsController < ApplicationController
  before_action :redirect_signed_in_user, except: [:destroy]
  
  def new
  end
  
  def create
    user = User.find_by_username params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # sign user in
      flash[:success] = "You have signed in."
      redirect_to root_path
    else
      flash.now[:error] = "Wrong username or password!"
      render "new"
    end
  end
  
  def destroy
    reset_session # sign user out
    flash[:success] = "You have signed out."
    redirect_to root_path
  end
end
