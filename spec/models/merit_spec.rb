require 'rails_helper'

describe Merit do
  describe '#create' do
    it "is valid with a title" do
      merit = build(:merit)
      expect(merit).to be_valid
    end

    # titleが空では登録できないこと
    it "is invalid without a title" do
      merit = build(:merit, title: nil)
      merit.valid?
      expect(merit.errors[:title]).to include("を入力してください")
    end
  end
end