require 'rails_helper'

describe Blog do
  describe '#create' do
    it "is valid with a text, chat, user" do
      blog = build(:blog)
      expect(blog).to be_valid
    end
    # titleが空では登録できないこと
    it "is invalid without a title" do
      blog = build(:blog, title: nil)
      blog.valid?
      expect(blog.errors[:title]).to include("を入力してください")
    end
    
    # textが空では登録できないこと
    it "is invalid without a text" do
      blog = build(:blog, text: nil)
      blog.valid?
      expect(blog.errors[:text]).to include("を入力してください")
    end

    # userが空では登録できないこと
    it "is invalid without a user" do
      blog = build(:blog, user: nil)
      blog.valid?
      expect(blog.errors[:user]).to include("を入力してください")
    end

  end
end