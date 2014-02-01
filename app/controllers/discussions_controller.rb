class DiscussionsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_project
  before_action :set_discussion, only: [:like, :edit]

  def create

    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to @project, notice: "Thanks for your discussion!"
    else
      render "projects/show"
    end
  end

  def edit
  end

  def show
    @discussion = Discussion.find(params[:id])
    @comment = Comment.new 
  end

  def update
    @discussion = Discussion.find(params[:id])
    @discussion.update_attributes(discussion_params)
    redirect_to @project
  end

  def discussion_params
    params.require(:discussion).permit(:title,:body)
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    if @discussion.user == current_user
      @discussion.destroy    
      redirect_to @project, notice: "Discussion deleted successfully"
    else
      redirect_to @project, notice: "Not cool man."      
    end
  end

  def like
    session[:discussion_ids] ||= []

    if session[:discussion_ids].include? params[:id].to_i
      redirect_to @discussion, alert: "Liked already"
    else 
      session[:discussion_ids] << @discussion.id
      @discussion.like_count += 1
      @discussion.save
      redirect_to @project, notice: "Thanks for liking!"
    end
  end

  private

  def set_discussion
    @discussion = current_user.discussions.find(params[:id])
  end

  def set_project
    @project = Project.find params[:project_id]
  end
  
end
