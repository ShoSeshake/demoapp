class Schedule < ApplicationRecord
  belongs_to :user

  enum day: [:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday]

  validates :day,  presence: true
  validates :start_time, :end_time, presence: true, if: :availability?
  validates :start_time, :end_time, presence: false, unless: :availability?
  validate :start_end_check

  def start_end_check
    if self.availability?
      if self.start_time.blank?
        errors.add(:start_time, "を入力してください")
      elsif self.end_time.blank?
        errors.add(:end_time, "を入力してください")
      elsif self.start_time >= self.end_time
        errors.add(:end_time, "を正しく記入してください")
      end
    end
  end
end
