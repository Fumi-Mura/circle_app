class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_target_blog, only: %i[show edit update destroy]
  
  def index
    @blogs = Blog.page(params[:page]).per(10)
  end

  def show
    @comment = Comment.new(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
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
    if @blog.user != current_user
      redirect_to blogs_path, alert: "不正なアクセスです"
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
 
  private
  def blog_params
      params.require(:blog).permit(:title, :content, :image)
  end
  
  def set_target_blog
    @blog = Blog.find(params[:id])
  end
  
end
