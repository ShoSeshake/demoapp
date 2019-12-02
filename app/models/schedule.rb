class Schedule < ApplicationRecord
  belongs_to :user

  enum day: [:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday]

  validates :day,  presence: true
  validates :start_time, :end_time, presence: true, if: :availability?
  validates :start_time, :end_time, presence: false, unless: :availability?
end
