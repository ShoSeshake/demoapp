class Api::VoicesController < ApplicationController
  def reload
    @chat = Chat.find(params[:chat_id])
    last_voice_id = params[:voice_id].to_i
    @voices = @chat.voices.includes(:user).where("id > #{last_voice_id} && user_id != #{current_user.id}")
    render "api/voices/index.js.erb"
  end
end