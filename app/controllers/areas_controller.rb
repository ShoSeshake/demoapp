class AreasController < ApplicationController

  before_action :header_menu

  def index
    @areas = Area.order('id DESC').limit(3)
    @advisers = User.where(adviser: true).order('id DESC').limit(3)
  end
  
  def show
    @area = Area.find(params[:id])
  end

  def search
    if params[:keyword]
      @q = Area.ransack(params[:q])
      @areas = Area.where('name LIKE(?)', "%#{params[:keyword]}%").order("created_at DESC").limit(20)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = Area.ransack(params[:q])
      @areas = @q.result(distinct: true)
    end
  end
end
