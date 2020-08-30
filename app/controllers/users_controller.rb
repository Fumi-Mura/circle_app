class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_user, only: %i(show edit update destroy following followers)
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
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
    if current_user.admin?
      if @user.admin == true
        redirect_to user_path(@user), alert: '管理者ユーザーは削除できません'
      else
        @user.destroy
        redirect_to users_path, notice: "管理者権限で#{@user.name}を削除しました"
      end
    elsif @user != current_user
      redirect_to user_path(@user), alert: '不正なアクセスです'
    else
      @user.destroy
      redirect_to new_user_registration_path, notice: "ユーザーを削除しました"
    end
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
end
