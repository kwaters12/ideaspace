class ProjectsController < ApplicationController
  

  before_action :set_project, only: [:edit, :show, :update, :destroy, :like]

  def index
    @projects = Project.find(:all)
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new project_params
    project.save
    redirect_to projects_path
  end

  def show
    @discussion = Discussion.new
    @task = Task.new
    @project.hit_count += 1
    @project.save   
    
  end

  def edit
  end

  def project_params
    params.require(:project).permit([:title, :body])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    redirect_to project_path
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def like
    session[:project_ids] ||= []

    if session[:project_ids].include? params[:id].to_i
      redirect_to @project, alert: "Liked already"
    else 
      session[:project_ids] << @project.id
      @project.like_count += 1
      @project.save
      redirect_to @project, notice: "Thanks for liking!"
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

end
