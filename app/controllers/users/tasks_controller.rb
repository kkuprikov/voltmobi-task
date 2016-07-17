class Users::TasksController < ApplicationController

  before_action :authorize

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to user_task_path(user_id: current_user.id, id: @task.id), notice: 'Task created!'
    else
      flash[:warning] = 'Please, fix the errors below and try again'
      render 'new'
    end
  end

  def show

  end

  def index
    @tasks = current_user.tasks
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :document).merge(user: current_user)
  end
end
