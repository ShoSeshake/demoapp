require 'rails_helper'

describe AreasMerit do
  describe '#create' do
    it "is valid with a merit, area" do
      areas_merit = build(:areas_merit)
      expect(areas_merit).to be_valid
    end

    # areaが空では登録できないこと
    it "is invalid without a area" do
      areas_merit = build(:areas_merit, area: nil)
      areas_merit.valid?
      expect(areas_merit.errors[:area]).to include("を入力してください")
    end

    # meritが空では登録できないこと
    it "is invalid without a merit" do
      areas_merit = build(:areas_merit, merit: nil)
      areas_merit.valid?
      expect(areas_merit.errors[:merit]).to include("を入力してください")
    end
  end
end