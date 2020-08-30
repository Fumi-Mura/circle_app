class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_blog, only: %i(show edit update destroy)

  def index
    @blogs = Blog.page(params[:page]).per(10).includes(:user)
  end

  def show
    @comment = Comment.new(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
    @circles = Circle.all
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blog_path(@blog), notice: "#{@blog.title}を投稿しました"
    else
      flash[:blog] = @blog
      flash[:error_messages] = @blog.errors.full_messages
      redirect_back fallback_location: @blog
    end
  end

  def edit
    if current_user.admin?
      flash[:notice] = '管理者権限で実行しています'
    elsif @blog.user != current_user
      redirect_to blog_path, alert: '不正なアクセスです'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: "#{@blog.title}を更新しました"
    else
      flash[:blog] = @blog
      flash[:error_messages] = @blog.errors.full_messages
      redirect_back fallback_location: @blog
    end
  end

  def destroy
    if current_user.admin?
      @blog.destroy
      redirect_to @blog.circle, notice: "管理者権限で#{@blog.title}ブログを削除しました"
    elsif @blog.user != current_user
      redirect_to blog_path, alert: "不正なアクセスです"
    else
      @blog.destroy
      redirect_to @blog.circle, notice: "#{@blog.name}ブログを削除しました"
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :circle_id)
  end

  def set_target_blog
    @blog = Blog.find(params[:id])
  end
end
