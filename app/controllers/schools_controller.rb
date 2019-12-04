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
      @q = School.ransack(search_params)
      @schools = @q.result(distinct: true)
    else
      params[:q] = { sorts: 'id desc' }
      @schools = School.all.order("created_at DESC")
      @q = School.ransack(params[:q])
    end
  end

  private
  def search_params
    params.require(:q).permit(
      :sorts,
      :name_cont,
      { location_in: [] },
      { schools_merits_merit_id_in: [] }
      )
  end
end
