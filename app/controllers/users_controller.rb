class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_user, only: %i[show edit update destroy following followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
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

  def edit
    if @user != current_user
      redirect_to users_path, alert: '不正なアクセスです'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "#{@user.name}さんの情報を更新しました"
    else
      flash[:user] = @user
      flash[:error_messages] = @user.errors.full_messages
      redirect_back fallback_location: @user
    end
  end

  def destroy
    user.destroy
    redirect_to new_user_registration_path, notice: "ユーザーを削除しました"
  end

  def following
    @title = "フォロー中"
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def current_user?(user)
    user && user == current_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_text, :profile_image)
  end

  def set_target_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
