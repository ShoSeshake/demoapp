class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :text, presence: true
end
