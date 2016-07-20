class Users::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to root_url, notice: "You have successfully signed up"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password).merge(role: :user)
  end
end
