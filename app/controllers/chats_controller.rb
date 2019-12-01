class ChatsController < ApplicationController
  require 'time'
  # before_action :authenticate_user!
  before_action :set_chat, only: [:update, :video, :recieve]
  before_action :chat_check, only: [:update, :video, :recieve]

  def new
    @chat = Chat.new
  end

  def create
    date = Date.today
    @chat = Chat.new(chat_params)
    if @chat.start_at < date
      redirect_to new_chat_path, alert: '明日以降の日程で指定してください'
    elsif @chat.save
      redirect_to new_chat_path, notice: '予約が完了しました'
    else
      redirect_to new_chat_path, alert: '予約できませんでした'
    end
  end

  def update
    @chat.update(chat_params)
    render 'update.js.erb', notice: '準備が完了しました'
  end

  def video
    gon.skyway_key = ENV['SKYWAY_KEY']
  end

  def receive
  end

  private
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_check 
    date = Time.now 
    open_time = @chat.start_at.to_datetime - Rational(5,24*60)
    close_time = @chat.start_at.to_datetime + Rational(30,24*60)
    if open_time > date 
      redirect_to root_path, alert: 'チャットルームは5分前に開きます'
    elsif close_time < date
      redirect_to root_path, alert: 'チャットルームは既に閉じています'
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
