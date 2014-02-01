class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_discussion, except: [:create]
  before_action :set_comment, only: [:edit, :update]

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = current_user.comments.new comment_params
    @comment.user = current_user
    @comment.discussion = @discussion
    @project = @discussion.project
    if @comment.save
      redirect_to project_discussion_path(@project, @discussion), notice: "Thanks for your comment!"
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
   
    @comment = Comment.find(params[:id])
    @project = @discussion.project
    if @comment.user == current_user
      @comment.destroy
      redirect_to project_discussion_path(@project, @discussion), notice: "Comment deleted successfully"
    else
      redirect_to project_discussion_path(@project, @discussion), notice: "Hey man, don't delete your buddy's comment."
      
    end
  end


  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end


  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  
end
