require 'rails_helper'

describe Chat do
  describe '#create' do
    it "is valid with a start_at,adviser,user" do
      chat = build(:chat)
      expect(chat).to be_valid
    end

    # start_atが空では登録できないこと
    it "is invalid without a start_at" do
      chat = build(:chat, start_at: nil)
      chat.valid?
      expect(chat.errors[:start_at]).to include("を入力してください")
    end

    # userが空では登録できないこと
    it "is invalid without a user" do
      chat = build(:chat, user: nil)
      chat.valid?
      expect(chat.errors[:user]).to include("を入力してください")
    end

    # adviserが空では登録できないこと
    it "is invalid without a adviser" do
      chat = build(:chat, adviser: nil)
      chat.valid?
      expect(chat.errors[:adviser]).to include("を入力してください")
    end
  end
end