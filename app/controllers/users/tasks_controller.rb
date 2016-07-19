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
    @task = Task.find(params[:id])
  end

  def index
    @tasks = current_user.tasks
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.attributes = task_params
    if @task.valid?
      @task.save(task_params)
      redirect_to user_task_path(user_id: current_user.id, id: @task.id), notice: 'Task updated'
    else
      flash[:warning] = 'Please, fix the errors below and try again'
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to action: :index, status: 303
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :document).merge(user: current_user)
  end
end
