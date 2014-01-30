class DiscussionsController < ApplicationController
  before_action :set_project
  before_action :set_discussion, only: [:destroy]

  def create
    @discussion = Discussion.new comment_params
    @project = Project.find params[:project_id]
    @discussion.project = @project
    if @discussion.save
      redirect_to @project, notice: "Thanks for your discussion!"
    else
      render "projects/show"
    end
  end

  def comment_params
    params.require(:discussion).permit(:body)
  end

  def destroy
    if @discussion.destroy
      redirect_to @project, notice: "Answer deleted successfully"
    else
      flash.now[:alert] = "We couldn't delete the answer"
      render "projects/show"
    end
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def set_project
    @project = Project.find params[:project_id]
  end
end
