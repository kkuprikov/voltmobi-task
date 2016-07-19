class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  
  def current_user
    @current_user ||= User.where(id: session[:id]).first if session[:id]
  end
  helper_method :current_user

  def authenticate
    redirect_to sign_in_url, alert: "Not authenticated" if current_user.nil?
  end
end
