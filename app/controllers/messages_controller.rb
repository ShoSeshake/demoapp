class MessagesController < ApplicationController


  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    if @message.save
      render "messages/create.js.erb"
    else

    end
  end
  
  private

  def message_params
    params.require(:message).permit(
      :text
    ).merge(user_id: current_user.id, chat_id: @chat.id)
  end
end
