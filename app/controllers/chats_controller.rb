class ChatsController < ApplicationController
  require 'time'
  before_action :authenticate_user!
  before_action :set_user, only: [:new,:create]
  before_action :set_chat, only: [:update, :video, :receive]
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
      current_user.update(ticket: current_user.ticket -= 1)
      # binding.pry
      redirect_to user_path(@user), notice: "予約が完了しました。#{@chat.start_at}からです"
    else
      redirect_to user_path(@user), alert: '予約できませんでした'
    end
  end

  def update
    @chat.update(update_params)
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

  def set_user
    @user = User.find(params[:user_id])
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
      :adviser_peer_id,
      :user_peer_id,
      :start_at
    ).merge(user_id: current_user.id, adviser_id: @user.id)
  end

  def update_params
    params.require(:chat).permit(
      :user_peer_id
    )
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
