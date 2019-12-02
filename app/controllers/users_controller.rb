class UsersController < ApplicationController
  before_action :header_menu
  def show
    @user = User.find(params[:id])
    @chat = Chat.new
  end
end
