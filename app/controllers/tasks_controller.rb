class TasksController < ApplicationController

  before_action :authenticate
  before_action :load_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: 'Task created!'
    else
      flash[:warning] = 'Please, fix the errors below and try again'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @task.attributes = task_params
    if @task.valid?
      @task.save(task_params)
      @task.send(params[:event].keys.first) if params[:event]
      redirect_to task_path(@task), notice: 'Task updated'
    else
      flash[:warning] = 'Please, fix the errors below and try again'
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to action: :index, status: 303
  end

  private

  def load_task
    @task = Task.where(id: params[:id]).first
  end

  def task_params
    params.require(:task).permit(:name, :description, :document, :user_id)
  end

end
