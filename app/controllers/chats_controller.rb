class ChatsController < ApplicationController
  require 'time'

  # before_action :set_chat, only: [:update, :video, :recieve]

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.save
    redirect_to new_chat_path
  end

  def update
    @chat = Chat.find(params[:id])
    @chat.update(chat_params)
    render 'update.js.erb'
  end

  def video
    @chat = Chat.find(params[:id])
    gon.skyway_key = ENV['SKYWAY_KEY']
  end

  def receive
    @chat = Chat.find(params[:id])
  end

  private
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_check 
    date = Time.now 
    entry_time = @chat.start_at.to_datetime - Rational(5,24*60)
    if entry_time > date
      redirect_tp '/admin'
    end
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
