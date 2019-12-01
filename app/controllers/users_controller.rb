class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @chat = Chat.new
  end
end
