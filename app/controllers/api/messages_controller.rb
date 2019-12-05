class Api::MessagesController < ApplicationController
  def reload
    @chat = Chat.find(params[:chat_id])
    last_message_id = params[:message_id].to_i
    @messages = @chat.messages.includes(:user).where("id > #{last_message_id} && user_id != #{current_user.id}")
    render "api/messages/index.js.erb"
  end
end