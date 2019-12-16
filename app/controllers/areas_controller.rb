class AreasController < ApplicationController

  before_action :header_menu

  def index
    @areas = Area.includes(:merits).where.not(ancestry: nil).order("RAND()").limit(3)
    @advisers = User.includes(:area).where(adviser: true).order('id DESC').limit(3)
  end
  
  def show
    @area = Area.includes(:merits).find(params[:id])
  end

  def search
    if params[:keyword]
      @q = Area.ransack(params[:q])
      @areas = Area.where('name LIKE(?) && ancestry != (?)', "%#{params[:keyword]}%","").order("created_at DESC").limit(20)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = Area.where.not(ancestry: nil).ransack(params[:q])
      @areas = @q.result(distinct: true)
    end
  end
end
