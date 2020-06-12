class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_user, only: %i[show edit update destroy]
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def show
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
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile_text, :profile_image)
  end
  
  def set_target_user
    @user = User.find(params[:id])
  end
end
