class Api::AreasController < ApplicationController
  def search
      @q = Area.ransack(search_params)
      @areas = @q.result(distinct: true)
  end

  private
  def search_params
    params.require(:q).permit(
      :sorts,
      :name_cont,
      { areas_merits_merit_id_in: [] }
      )
  end
end