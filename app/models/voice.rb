class Voice < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :text, presence: true
end
