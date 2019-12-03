class SignupsController < ApplicationController

  # before_action :validation, only: :schedule

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
      binding.pry
      @user.schedules.build
      render adviser_signups_path
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
      render user_signups_path
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
      :school_id,
      schedules_attributes:[:id,:day,:availability,:start_time, :end_time]
    ).merge(adviser: 1)
  end
end
