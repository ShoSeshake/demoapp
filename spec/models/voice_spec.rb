require 'rails_helper'

describe Voice do
  describe '#create' do
    it "is valid with a text, chat, user" do
      voice = build(:voice)
      expect(voice).to be_valid
    end

    # textが空では登録できないこと
    it "is invalid without a text" do
      voice = build(:voice, text: nil)
      voice.valid?
      expect(voice.errors[:text]).to include("を入力してください")
    end

    # userが空では登録できないこと
    it "is invalid without a user" do
      voice = build(:voice, user: nil)
      voice.valid?
      expect(voice.errors[:user]).to include("を入力してください")
    end

    # chatが空では登録できないこと
    it "is invalid without a chat" do
      voice = build(:voice, chat: nil)
      voice.valid?
      expect(voice.errors[:chat]).to include("を入力してください")
    end
  end
end