module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id session[:user_id]
    elsif cookies.signed[:user_id]
      user = User.find_by_id cookies.signed[:user_id]
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
  end
  
  def admin?
    current_user && current_user.admin?
  end

  def user_signed_in?
    !current_user.nil?
  end
  
  def current_user?(id)
    session[:user_id] == id.to_i
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def forget(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def sign_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def user_auth
    unless user_signed_in?
      store_previous_url
      flash[:error] = "You must sign in to continue."
      redirect_to sign_in_path
    end
  end
  
  def admin_auth
    unless admin?
      store_previous_url
      flash[:error] = "Permission denied!"
      redirect_to root_path
    end
  end
  
  def redirect_back_or_to(path)
    if session[:previous_url]
      redirect_to session[:previous_url]
      delete_previous_url
    else
      redirect_to path
    end
  end

  def store_previous_url
    session[:previous_url] = request.url if request.get?
  end

  def delete_previous_url
    session.delete :previous_url
  end

  def redirect_signed_in_user
    if user_signed_in?
      flash[:error] = "You are already signed in."
      redirect_to root_path
    end
  end

  def redirect_admin_user_to(path)
    redirect_to path if admin?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
