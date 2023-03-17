class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_signin
    redirect_to new_session_path, alert:'Please sign in first' unless current_user
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?
    current_user && current_user.admin?
  end

  def require_admin?
    unless current_user_admin?
        redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  helper_method :current_user_admin?

end
