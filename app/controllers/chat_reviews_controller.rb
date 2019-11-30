class ChatReviewsController < ApplicationController
  def new
    @chat = Chat.find(params[:chat_id])
    @chat_review = ChatReview.new
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @chat_review = ChatReview.new(chat_review_params)
    if @chat_review.save
      redirect_to '/'
    else
      @chat_review = ChatReview.new
      render :new
    end
  end

  private
  def chat_review_params
    params.require(:chat_review).permit(
      :score,
      :text
    ).merge(user_id: current_user.id,chat_id: @chat.id)
  end
end
