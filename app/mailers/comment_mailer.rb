class CommentMailer < ApplicationMailer
  default from: 'driftingeric@gmail.com'
  
  def notify_comment(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "Someone commented on your post") if @owner
  end
end
