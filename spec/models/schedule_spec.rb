require 'rails_helper'

describe Schedule do
  describe '#create' do
    it "is valid with a availability, day, start_time, end_time" do
      schedule = build(:schedule)
      expect(schedule).to be_valid
    end

    # dayが空では登録できないこと
    it "is invalid without a day" do
      schedule = build(:schedule, day: nil)
      schedule.valid?
      expect(schedule.errors[:day]).to include("を入力してください")
    end

    # start_timeが空では登録できないこと
    it "is invalid without a start_time" do
      schedule = build(:schedule, start_time: nil)
      schedule.valid?
      expect(schedule.errors[:start_time]).to include("を入力してください")
    end

    # end_timeが空では登録できないこと
    it "is invalid without a end_time" do
      schedule = build(:schedule, end_time: nil)
      schedule.valid?
      expect(schedule.errors[:end_time]).to include("を入力してください")
    end

    # start_timeがend_timeより早い時間でないと登録できないこと
    it "is invalid without a end_time" do
      schedule = build(:schedule, start_time:Time.now,end_time:Time.now )
      schedule.valid?
      expect(schedule.errors[:end_time]).to include("を正しく記入してください")
    end

    # avaialabilityがfalseならstart_timeとend_timeが空でも登録できること
    it "is valid without an end_time and start_time if availability is not true" do
      schedule = build(:schedule, availability: 0, end_time: nil, start_time: nil)
      expect(schedule).to be_valid
    end

    # userが空では登録できないこと
    it "is invalid without a user" do
      schedule = build(:schedule, user: nil)
      schedule.valid?
      expect(schedule.errors[:user]).to include("を入力してください")
    end
  end
end