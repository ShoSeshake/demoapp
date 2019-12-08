class SignupsController < ApplicationController


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
    logger.debug("[debug] signups#icreate")
    logger.info("[info] signups#icreate")
    logger.warn("[warn] signups#icreate")
    logger.error("[error] signups#icreate")
    logger.fatal("[fatal] signups#icreate")
    @user =User.new(user_params)
    if @user.save
      sign_in @user unless user_signed_in?
      redirect_to complete_signups_path
    else
      render user_signups_path, alert: "必須項目を全てご記入ください"
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

  def schedule_check(user)
    user.schedules.each do |s|
      if s.availability?
        render :adviser unless s.start_time.strftime('%H:%M').to_datetime < s.end_time.strftime('%H:%M').to_datetime
      else
      end
    end
  end
end
