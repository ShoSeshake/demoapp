class Chat < ApplicationRecord
  belongs_to :adviser, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :chat_reviews

  validates :start_at presence: true
end
