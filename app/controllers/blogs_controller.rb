class BlogsController < ApplicationController

  before_action :set_blog, only: [:show,:edit,:update,:delete]
  before_action :user_check, only:  [:edit,:update,:delete]
  def index
    
  end

  def show
    
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @blog.save
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def delete
    if @blog.destroy
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
    
  private
  def blog_params
    params.require(:blog).permit(
      :title,
      :text
    ).merge(user_id: current_user.id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def user_check
    redirect_to root_path unless current_user == @blog.user
  end
  
end
