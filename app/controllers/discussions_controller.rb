class DiscussionsController < ApplicationController
  before_action :set_project
  before_action :set_discussion, only: [:show, :destroy, :like, :edit]

  def create
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    if @discussion.save
      redirect_to @project, notice: "Thanks for your discussion!"
    else
      render "projects/show"
    end
  end

  def edit
  end

  def show
    @comment = Comment.new 
  end

  def update
    @discussion = Discussion.find(params[:id])
    @discussion.update_attributes(discussion_params)
    redirect_to project_path
  end

  def discussion_params
    params.require(:discussion).permit(:title,:body)
  end

  def destroy
    if @discussion.destroy
      redirect_to @project, notice: "Answer deleted successfully"
    else
      flash.now[:alert] = "We couldn't delete the answer"
      render "projects/show"
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
    @discussion = Discussion.find(params[:id])
  end

  def set_project
    @project = Project.find params[:project_id]
  end
  
end
