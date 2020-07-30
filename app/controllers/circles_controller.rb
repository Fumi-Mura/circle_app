class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_circle, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[index new edit]

  def index
    @categories = Category.all
    @q = Circle.ransack(params[:q])
    @circles = @q.result.includes(:categories).page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @circles = Circle.all
    @user = User.find(params[:id])
    @users = User.all
    @blogs = Blog.all.order(created_at: :desc)
    @blog = Blog.new(circle_id: @circle.id)
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
    @categories = Category.all
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
      redirect_to circle_path, alert: '不正なアクセスです'
    end
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
    if @circle.user != current_user
      redirect_to circle_path, alert: "不正なアクセスです"
    else
      @circle.destroy
      redirect_to circles_path, notice: "#{@circle.name}サークルを削除しました"
    end
  end

  def search
    @q = Circle.search(search_params)
    @circles = @q.result.includes(:categories).page(params[:page]).per(10)
  end

  private
  def search_params
    params.require(:q).permit(:name_cont, :categories_id_eq)
  end

  def circle_params
    params.require(:circle).permit(:image, :name, :content, category_ids: [])
  end

  def set_target_circle
    @circle = Circle.find(params[:id])
  end

  def set_categories
    @kinds = Category.all[0..7]
    @places = Category.all[8..55]
  end
end
