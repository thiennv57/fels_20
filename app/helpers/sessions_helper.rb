module SessionsHelper
  def current_user
    User.find_by_id session[:user_id]
  end
  
  def user_signed_in?
    !current_user.nil?
  end
  
  def current_user?(id)
    session[:user_id] == id.to_i
  end

  def user_auth
    unless user_signed_in?
      flash[:error] = "You must sign in to continue."
      redirect_to root_path
    end
  end
  
  def admin_auth
    unless current_user.admin?
      flash[:error] = "Permission denied!"
      redirect_to root_path
    end
  end
  
  def redirect_signed_in_user
    if user_signed_in?
      flash[:error] = "You are already signed in."
      redirect_to root_path
    end
  end
end
