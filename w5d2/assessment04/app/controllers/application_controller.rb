class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user = User.find_by(session_token: session[:session_token])
  end

  def login_user(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout_user
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login!
    redirect_to new_session_url unless current_user
  end

  def require_logout!
    redirect_to tweets_url if current_user
  end
end
