class VoicesController < ApplicationController


  def create
    @chat = Chat.find(params[:chat_id])
    @voice = Voice.new(voice_params)
    if @voice.save
      render "voices/create.js.erb"
    else
      
    end
  end
  
  private

  def voice_params
    params.require(:voice).permit(
      :text
    ).merge(user_id: current_user.id, chat_id: @chat.id)
  end
end
