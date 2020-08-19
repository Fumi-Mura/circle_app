class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
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
    params.require(:comment).permit(:blog_id, :name, :comment)
  end
end
