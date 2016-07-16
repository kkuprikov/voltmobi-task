class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  
  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end
  helper_method :current_user

  def authorize
    redirect_to sign_in_url, alert: "Not authorized" if current_user.nil?
  end
end
