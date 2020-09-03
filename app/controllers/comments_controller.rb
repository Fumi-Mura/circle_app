class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    blog = comment.blog
    if comment.save
      blog.create_notification_comment!(current_user, comment.id)
      redirect_to comment.blog, notice: "コメントを投稿しました"
    else
      flash[:comment] = comment
      flash[:error_messages] = comment.errors.full_messages
      redirect_back fallback_location: comment.blog
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comment.blog, notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:blog_id, :comment)
  end
end
