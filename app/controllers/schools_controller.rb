class SchoolsController < ApplicationController

  before_action :header_menu

  def index
    @schools = School.all
    @advisers = User.where(adviser: true).limit(10)
  end
  
  def show
    @school = School.find(params[:id])
  end

  def search
    @schools = School.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
  end
end
