class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_circle, only: %i[show edit update destroy]
  
  def index
    @circles = params[:category_id].present? ? Category.find(params[:category_id]).circles : Circle.all
    @circles = @circles.page(params[:page]).per(10)
    @kinds = Category.all[0..7]
    @places = Category.all[8..55]
  end
  
  def show
    @circles = Circle.all
    @user = User.find(params[:id])
    @blogs = Blog.all
    binding.pry
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def new
    @circle = Circle.new
    @kinds = Category.all[0..7]
    @places = Category.all[8..55]
  end
  
  def create
    @circle = Circle.new(circle_params)
    @circle.user_id = current_user.id
    if @circle.save
      redirect_to circle_path(@circle), notice: "#{@circle.name}を作成しました"
    else
      flash[:circle] = @circle
      flash[:error_messages] = @circle.errors.full_messages
      redirect_back fallback_location: @circle
    end
  end

  def edit
    if @circle.user != current_user
      redirect_to circles_path, alert: '不正なアクセスです'
    end
    @kinds = Category.all[0..7]
    @places = Category.all[8..55]
  end
  
  def update
    if @circle.update(circle_params)
      redirect_to circle_path(@circle), notice: "#{@circle.name}の情報を更新しました"
    else
      flash[:circle] = @circle
      flash[:error_messages] = @circle.errors.full_messages
      redirect_back fallback_location: @circle
    end
  end
  
  def destroy
  end
  
  
  private 
  def circle_params
    params.require(:circle).permit(:image, :name, :content, category_ids: [])
  end
  
  def set_target_circle
    @circle = Circle.find(params[:id])
  end
  
end
