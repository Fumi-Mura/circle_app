class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile_text, :profile_image)
  end
end
