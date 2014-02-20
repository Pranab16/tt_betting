class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    @current_user = User.find_by_id(session[:user_id]) if session[:user_id]
    unless @current_user
      redirect_to login_path
    end
  end

  def require_admin
    unless @current_user.is_superuser
      redirect_to :root
    end
  end

  def require_normal_user
    if @current_user.is_superuser
      redirect_to :root
    end
  end
end
