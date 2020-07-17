class HomeController < ApplicationController
  def index
    @categories = Category.all
    @kinds = Category.all[0..7]
    @places = Category.all[8..55]
    @q = Circle.ransack(params[:q])
    @circles = @q.result.includes(:categories).page(params[:page]).per(10).order(created_at: :desc)
  end
  
  def search
    @q = Circle.search(search_params)
    @circles = @q.result.includes(:categories).page(params[:page]).per(10)
  end
  
end
