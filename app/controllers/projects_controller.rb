class ProjectsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new project_params
    @project.save
    redirect_to projects_path
    @project.user = current_user
  end

  def show
    @project = Project.find(params[:id])
    @discussion = Discussion.new
    @task = Task.new
    @project.hit_count += 1
    @project.save   
    
  end

  def edit
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
    if @project.user == current_user
      @project.destroy
      redirect_to projects_path, notice: "Project Deleted Successfully"
    else
      redirect_to projects_path, notice: "Hey man, don't delete your buddy's project."      
    end    
  end

  def like
    @project = Project.find(params[:id])
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

  def authorize
    redirect_to root_path, alert: "access denied" unless can? :manage, @project
  end

end
