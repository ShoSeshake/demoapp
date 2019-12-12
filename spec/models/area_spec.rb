require 'rails_helper'

describe Area do
  describe '#create' do
    it "is valid with a name, description" do
      area = build(:area)
      expect(area).to be_valid
    end

    # nameが空では登録できないこと
    it "is invalid without a name" do
      area = build(:area, name: nil)
      area.valid?
      expect(area.errors[:name]).to include("を入力してください")
    end

    # descriptionが空では登録できないこと
    it "is invalid without a description" do
      area = build(:area, description: nil)
      area.valid?
      expect(area.errors[:description]).to include("を入力してください")
    end
  end
end