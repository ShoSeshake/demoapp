class ChatReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def new
    @chat_review = ChatReview.new
  end

  def create
    @chat_review = ChatReview.new(chat_review_params)
    if @chat_review.save
      redirect_to root_path, notice: 'レビューのご記入ありがとうございました'
    else
      @chat_review = ChatReview.new
      render :new, alert: 'レビューの記入をお願いします'
    end
  end

  private
  def chat_review_params
    params.require(:chat_review).permit(
      :score,
      :text
    ).merge(user_id: current_user.id,chat_id: @chat.id)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end
end
