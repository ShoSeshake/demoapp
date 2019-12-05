class SchoolsController < ApplicationController

  before_action :header_menu

  def index
    @schools = School.order('id DESC').limit(3)
    @advisers = User.where(adviser: true).order('id DESC').limit(3)
  end
  
  def show
    @school = School.find(params[:id])
  end

  def search
    if params[:keyword]
      @q = School.ransack(params[:q])
      @schools = School.where('name LIKE(?)', "%#{params[:keyword]}%").order("created_at DESC").limit(20)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = School.ransack(params[:q])
      @schools = @q.result(distinct: true)
    end
  end
end
