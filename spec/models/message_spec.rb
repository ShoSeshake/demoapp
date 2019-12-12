require 'rails_helper'

describe Message do
  describe '#create' do
    it "is valid with a text, chat, user" do
      message = build(:message)
      expect(message).to be_valid
    end

    # textが空では登録できないこと
    it "is invalid without a text" do
      message = build(:message, text: nil)
      message.valid?
      expect(message.errors[:text]).to include("を入力してください")
    end

    # userが空では登録できないこと
    it "is invalid without a user" do
      message = build(:message, user: nil)
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end

    # chatが空では登録できないこと
    it "is invalid without a chat" do
      message = build(:message, chat: nil)
      message.valid?
      expect(message.errors[:chat]).to include("を入力してください")
    end
  end
end