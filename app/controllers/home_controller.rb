class HomeController < ApplicationController
  def index
    @blog_ranks = Blog.find(Like.group(:blog_id).order('count(blog_id) desc').limit(10).pluck(:blog_id))
  end
  
  def search
    @q = Circle.search(search_params)
    @circles = @q.result.includes(:categories).page(params[:page]).per(10)
  end
  
end
