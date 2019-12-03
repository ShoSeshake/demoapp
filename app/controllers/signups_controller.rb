class SignupsController < ApplicationController

  before_action :validation, only: :schedule

  def adviser
    reset_session
    @user =User.new
  end
  
  def schedule
    session[:name] = adviser_params[:name]
    session[:email] = adviser_params[:email]
    session[:password] = adviser_params[:password]
    session[:password_confirmation] = adviser_params[:password_confirmation]
    session[:icon] = adviser_params[:icon]
    session[:background_image] = adviser_params[:background_image]
    session[:profile] = adviser_params[:profile]
    @user =User.new
    @user.schedules.build
  end
  
  def adviser_create
    binding.pry
    @user = User.new(
      name: session[:name], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      icon: session[:icon], 
      background_image: session[:background_image], 
      profile: session[:profile],
      adviser: 1,
      schoold_id: adviser_params(:school_id)
    )
    @user.schedules.build(adviser_params[:schedules_attributes])
    if @user.save
      sign_in @user unless user_signed_in?
      redirect_to complete_signups_path
    else
      render schedule_signups_path
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

  def validation
    session[:name] = adviser_params[:name]
    session[:email] = adviser_params[:email]
    session[:password] = adviser_params[:password]
    session[:password_confirmation] = adviser_params[:password_confirmation]
    session[:profile] = adviser_params[:profile]

    @user = User.new(
      name: session[:name], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      profile: session[:profile],
      adviser: 1
    )
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
      :adviser,
      :school_id,
      schedules_attributes:[:id,:day,:availability,:start_time, :end_time]
    )
  end
end
