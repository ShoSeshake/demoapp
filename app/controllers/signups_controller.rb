class SignupsController < ApplicationController

  def registration
  end

  def adviser
    @user =User.new
    @user.schedules.build
  end

    def adviser_create
    @user = User.new(adviser_params)
    if @user.save
      sign_in @user unless user_signed_in?
      redirect_to complete_signups_path
    else
      redirect_to adviser_signups_path, alert: "必須項目を全てご記入ください"
    end
  end
  
  def user
    @user =User.new
  end

  def create
    @user =User.new(user_params)
    if @user.save
      sign_in @user unless user_signed_in?
      redirect_to complete_signups_path
    else
      flash.now[:alert] = "必須項目を全てご記入ください"
      render :user
    end
  end


  def complete
  end

  private

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation, 
      :icon, 
      :background_image,
      :profile
    ).merge(ticket: 10)
  end

  def adviser_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation, 
      :icon, 
      :background_image,
      :profile,
      :area_id,
      schedules_attributes:[:id,:day,:availability,:start_time, :end_time]
    ).merge(adviser: 1)
  end
end
