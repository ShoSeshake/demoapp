class Schedule < ApplicationRecord
  belongs_to :user

  enum day: [:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday]

  validates :day,  presence: true
  validates :start_time, :end_time, presence: true, if: :availability?
  validates :start_time, :end_time, presence: false, unless: :availability?
  validate :start_end_check, unless: :availability?

  def start_end_check
    if self.availability?
      errors.add(:end_time, "の日付を正しく記入してください。") unless
      self.start_time < self.end_time
      binding.pry
    end
  end
end
