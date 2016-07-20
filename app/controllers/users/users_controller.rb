class Users::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      if @user.role == 'admin'
        redirect_to root_url, notice: "You have successfully signed up"
      else
        redirect_to user_tasks_url(@user), notice: "You have successfully signed up"
      end
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password).merge(role: :user)
  end
end
