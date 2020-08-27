class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog

  def create
    @like = current_user.likes.create(blog_id: params[:blog_id])
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js
    end
  end

  def destroy
    @like = current_user.likes.find_by(blog_id: @blog.id)
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js
    end
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end
