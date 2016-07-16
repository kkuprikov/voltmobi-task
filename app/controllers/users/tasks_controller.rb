class Users::TasksController < ApplicationController

  before_action :authorize

  def show

  end

  def index
    @tasks = current_user.tasks
  end
end
