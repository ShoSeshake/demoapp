class Chat < ApplicationRecord
  belongs_to :adviser, class_name: "User"
  belongs_to :user, class_name: "User"
  has_many :chat_reviews
  has_many :messages
  has_many :voices

  validates :start_at, presence: true
  validate :double_booking

  scope :incoming,  -> { where('start_at > ?', Time.zone.now.to_datetime - Rational(20,24*60)) }

  def double_booking
    adviser_chat = Chat.where("start_at = ? and adviser_id =?", self.start_at, self.adviser_id)
    user_chat = Chat.where("start_at = ? and user_id =?", self.start_at, self.user_id)
    errors.add(:start_at, "既にその時間は予約があります") if adviser_chat.present? || user_chat.present?
  end
end
