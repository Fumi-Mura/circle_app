class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like = current_user.likes.create(blog_id: params[:blog_id])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @blog = Blog.find(params[:blog_id])
    @like = current_user.likes.find_by(blog_id: @blog.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
