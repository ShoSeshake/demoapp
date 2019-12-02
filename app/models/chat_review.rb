class ChatReview < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :reviewee, class_name: "User"
  belongs_to :chat

  validates :score, :text, presence: true
end
