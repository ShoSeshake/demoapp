class ChatReviewsController < ApplicationController
  def new
    @chat_review = ChatReview.new
  end

  def create
  end

  private
  def chat_review_params

  end

end
