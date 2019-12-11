class Api::AreasController < ApplicationController
  def search
      areas = Area.where.not(ancestry: nil)
      @q = areas.ransack(search_params)
      @areas = @q.result(distinct: true)
  end

  private
  def search_params
    if params[:parent].present?
      area_ids = []
      params[:parent].each do |parent|
        area = Area.find(parent.to_i)
        area_ids.push(area.descendant_ids)
        area_ids.flatten!
      end
    end
    
    params.require(:q).permit(
      :sorts,
      :name_cont,
      { areas_merits_merit_id_in: [] }
    ).merge(id_in: area_ids)
  end
end