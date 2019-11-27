class ChatReview < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :score, :text, presence: true
end
