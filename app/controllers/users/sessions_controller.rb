class Users::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_to root_url, notice: "You have logged in"
    else
      redirect_to sign_in_url, alert: "Wrong password"
    end
  end
  
  def destroy
    session[:id] = nil
    redirect_to sign_in_url, notice: "You have logged out"
  end
end
