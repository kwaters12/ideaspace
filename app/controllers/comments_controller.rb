class CommentsController < ApplicationController
  
  before_action :set_discussion
  before_action :set_comment, only: [:show, :destroy, :edit, :update]

  def create
    @comment = Comment.new comment_params
    @discussion = Discussion.find(params[:discussion_id])
    @comment.discussion = @discussion
    project = @discussion.project_id

    if @comment.save
      redirect_to project_discussion_path(project, @discussion), notice: "Thanks for your comment!"
    else
      render "discussions/show"
    end
  end

  def edit
  end

  def update
    @comment = comment.find(params[:id])
    @comment.update_attributes(comment_params)
    redirect_to project_path
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def destroy
    project = @discussion.project_id
    if @comment.destroy
      redirect_to project_discussion_path(project, @discussion), notice: "Answer deleted successfully"
    else
      flash.now[:alert] = "We couldn't delete the answer"
      render "projects/show"
    end
  end


  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end
  
end
