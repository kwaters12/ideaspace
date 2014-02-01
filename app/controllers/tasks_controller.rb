class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :destroy, :like, :edit, :complete]

  def create
    @task = current_user.tasks.new task_params
    @task.project = @project
    if @task.save
      redirect_to @project, notice: "Thanks for your task!"
    else
      render "projects/show"
    end
  end

  def edit
  end

  def show
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    redirect_to project_path
  end

  def task_params
    params.require(:task).permit(:name, :due_date, :completed)
  end

  def destroy
    if @task.destroy
      redirect_to @project, notice: "Task deleted successfully"
    else
      flash.now[:alert] = "We couldn't delete the answer"
      render "projects/show"
    end
  end

  def complete
    @task.completed = true
    @task.save
    redirect_to @project
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = current_user.projects.find params[:project_id]
  end
end
