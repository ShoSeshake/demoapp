class Chat < ApplicationRecord
  belongs_to :adviser, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :chat_reviews

  validates :start_at, presence: true

  scope :incoming,  -> { where('start_at > ?', Time.zone.now.to_datetime - Rational(20,24*60)) }
end
