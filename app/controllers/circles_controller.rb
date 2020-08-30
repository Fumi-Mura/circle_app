class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_circle, only: %i(show edit update destroy)
  before_action :set_categories, only: %i(index show new edit create update)
  before_action :set_places, only: %i(index new show edit search)

  def index
    @categories = Category.all
    @q = Circle.ransack(params[:q])
    @circles = @q.result.includes(:categories).page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @circles = Circle.all
    @circle = Circle.find(params[:id])
    @user = User.find(params[:id])
    @users = User.all
    @blogs = Blog.all.order(created_at: :desc)
    @blog = Blog.new(circle_id: @circle.id)
    if user_signed_in?
      @current_user_entry = Entry.where(user_id: current_user.id)
      @user_entry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id
              @is_room = true
              @room_id = cu.room_id
            end
          end
        end
        unless @is_room
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
    if current_user.admin?
      flash[:notice] = '管理者権限で実行しています'
    elsif @circle.user != current_user
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
    if current_user.admin?
      @circle.destroy
      redirect_to circles_path, notice: "管理者権限で#{@circle.name}サークルを削除しました"
    elsif @circle.user != current_user
      redirect_to circle_path, alert: "不正なアクセスです"
    else
      @circle.destroy
      redirect_to circles_path, notice: "#{@circle.name}サークルを削除しました"
    end
  end

  def set_places
    @places = %w(
      北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 山梨県 長野県
      新潟県 富山県 石川県 福井県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県
      山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県 その他
    )
  end

  def search
    @q = Circle.search(search_params)
    @circles = @q.result.includes(:categories).page(params[:page]).per(10)
  end

  private

  def search_params
    params.require(:q).permit(:name_cont, :place_cont, :categories_id_eq)
  end

  def circle_params
    params.require(:circle).permit(:image, :name, :content, :place, category_ids: [])
  end

  def set_target_circle
    @circle = Circle.find(params[:id])
  end

  def set_categories
    @kinds = Category.all
  end
end
