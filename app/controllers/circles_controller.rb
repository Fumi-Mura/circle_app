class CirclesController < ApplicationController
  def index
    @circle = Circle.all
    @circles = params[:category_id].present? ? Category.find(params[:category_id]).circles : Circle.all
    @q = Circle.ransack(params[:q])
    @circles = @q.result(distinct: true)
  end
  
  def show
    @circle = Circle.find(params[:id])
  end

  def new
    @circle = Circle.new
  end
  
  def create
    @circle = Circle.new(circle_params)
    @circle.user_id = current_user.id
    @circle.save
    redirect_to circle_path(@circle)
  end

  def edit
    @circle = Circle.find(params[:id])
  end
  
  def update
    @circle = Circle.find(params[:id])
    @circle.update(circle_params)
    redirect_to circle_path(@circle)
  end
  
  private 
  def circle_params
    params.require(:circle).permit(:image, :name, :content, kind_ids: [], place_ids: [])
  end
  
end
