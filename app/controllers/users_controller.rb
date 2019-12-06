class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :header_menu
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @adviser_chats = Chat.where(adviser_id: @user.id).incoming.order(start_at: :asc)
    gon.chats = []
    @adviser_chats.each do |a|
      gon.chats << a.start_at.strftime("%Y-%m-%d:%H%M")
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user), notice: "編集が完了しました"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if @user.valid_password?(params[:user][:current_password])
      if params[:user][:password].present? && params[:user][:password_confirmation].present?
      params.require(:user).permit(
        :name, 
        :email, 
        :password, 
        :password_confirmation, 
        :icon, 
        :background_image,
        :profile
      )
    else
        params.require(:user).permit(
          :name, 
          :email, 
          :icon, 
          :background_image,
          :profile
        ).merge(password: params[:user][:current_password], 
          password_confirmation: params[:user][:current_password])
      end
    else
      return false
    end
  end

end
