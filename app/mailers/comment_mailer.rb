class CommentMailer < ActionMailer::Base
  default from: "gpgkelly@gmail.com"

  def notify_owner comment
    @comment = comment
    @sending_user = comment.user
    @discussion = comment.discussion
    @receiving_user = @discussion.user
    mail(to: @receiving_user.email, subject: "You have received a comment on #{@discussion.title}" )
  end
end

 #      @answer   = answer
 # +    @question = answer.question
 # +    @user     = @question.user
 # +    mail(to: @user.email, subject: "You got new answer for your question #{@question.title}")

# class AnswerMailer < ActionMailer::Base
#   default from: "gpgkelly@gmail.com"

#   def notify_owner comment
#     @comment = comment
#     @sending_user = @comment.user
#     @project = @comment.project
#     @receiving_user = @project.user
#     mail(to: @receiving_user.email, subject: "You've received a new comment on your project: #{@project.title.truncate(25)}")
#   end

  
# end
