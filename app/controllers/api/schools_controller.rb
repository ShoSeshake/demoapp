class Api::SchoolsController < ApplicationController
  def search
      @q = School.ransack(search_params)
      @schools = @q.result(distinct: true)
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