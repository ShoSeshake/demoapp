class SchoolsController < ApplicationController

  before_action :header_menu

  def index
    @schools = School.all
    @advisers = User.where(adviser: true).order('id DESC').limit(10)
  end
  
  def show
    @school = School.find(params[:id])
  end

  def search
    if params[:keyword]
      @q = School.ransack(params[:q])
      @schools = School.where('name LIKE(?)', "%#{params[:keyword]}%").order("created_at DESC").limit(20)
    elsif params[:q]
      @schools = School.order("created_at DESC")
      @q = School.ransack(params[:q])
    else
      params[:q] = { sorts: 'id desc' }
      @schools = School.all.order("created_at DESC")
      @q = School.ransack(params[:q])
    end
  end

  private
  def search_params
  end
end
