class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :header_menu
  before_action :set_user

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation, 
      :icon, 
      :background_image,
      :profile
    )
  end

end
