class ChatsController < ApplicationController
  require 'time'
  before_action :authenticate_user!
  before_action :set_user, only: [:new,:create]
  before_action :set_chat, only: [:update, :video, :receive, :test]
  before_action :chat_check, only: [:update, :video, :receive]

  def new
    @chat = Chat.new
    @start_times = start_times(@user)
    render 'new.js.erb'
  end

  def create
    date = Date.today
    @chat = Chat.new(chat_params)
    if @chat.start_at < date.tomorrow
      redirect_to user_path(@user), alert: '明日以降の日程で指定してください'
    elsif @chat.save
      current_user.use_ticket
      redirect_to user_path(@user), notice: "予約が完了しました。#{@chat.start_at.strftime("%Y年%m月%d日 %H:%M")}からです"
    else
      redirect_to user_path(@user), alert: '予約できませんでした'
    end
  end

  def update
    @chat.update_attribute(:user_peer_id, params[:chat][:user_peer_id])
    render 'update.js.erb'
  end

  def test
    @chat.update_attribute(:start_at, DateTime.now)
    redirect_to user_path(current_user), notice: "予約日時を変更しました。#{@chat.start_at.strftime("%Y年%m月%d日 %H:%M")}からです"
  end

  def video
    gon.skyway_key = ENV['SKYWAY_KEY']
    @messages = Message.where(chat_id: @chat.id).order('id ASC')
    @voices = Voice.where(chat_id: @chat.id).order('id ASC')
    gon.chat_id = @chat.id
    @message = Message.new
    @voice = Voice.new
  end

  def receive
  end

  private
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
    redirect_to user_path(@user) if (current_user.ticket < 0 || current_user.adviser?)
  end

  def chat_check 
    date = Time.now 
    open_time = @chat.start_at.to_datetime - Rational(5,24*60)
    close_time = @chat.start_at.to_datetime + Rational(30,24*60)
    if current_user != @chat.user && current_user != @chat.adviser
      redirect_to root_path, alert: 'この部屋に入ることはできません'
    elsif open_time > date 
      redirect_to root_path, alert: 'チャットルームは5分前に開きます'
    elsif close_time < date
      redirect_to root_path, alert: 'チャットルームは既に閉じています'
    end
  end

  def chat_params
    params.require(:chat).permit(
      :user_peer_id,
      :start_at
    ).merge(user_id: current_user.id, adviser_id: @user.id)
  end

  def start_times(user)
    schedules = user.schedules
    start_times = []
    schedules.each do |s|
      if s.availability?
        time = s.start_time.to_datetime
        while (time.strftime('%H:%M').to_datetime < s.end_time.strftime('%H:%M').to_datetime) do
          start_time = {day: s.day, start_time: time.strftime('%H:%M')}
          start_times << start_time
          time += Rational(30,24*60)
        end
      else
        start_time = {day: s.day, start_time: "none"}
        start_times << start_time
      end
    end
    return start_times
  end
end
