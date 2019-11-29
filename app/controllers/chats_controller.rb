class ChatsController < ApplicationController
  
  # before_action :set_chat

  def video
    @chat = Chat.find(1)
    gon.skyway_key = ENV['SKYWAY_KEY']
  end

  def update
    @chat = Chat.find(params[:id])
    @chat.update(chat_params)
    render 'update.js.erb'
  end

  def receive
    @chat = Chat.find(params[:id])
    render 'receive.js.erb'
  end

  private
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(
      :adviser_id,
      :adviser_peer_id,
      :user_peer_id,
      :start_at
    ).merge(user_id: current_user.id)
  end
end
