require 'rails_helper'

describe User do
  describe '#create' do
    it "is valid with a name, email, password, icon, profile, ticket" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nameが空では登録できないこと
    it "is invalid without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  # emailに正確ではない
    it "is invalid if email is already invalid" do
      user = build(:user, email:"abc")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end


    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # passwordとpassword_confirmationが別であると登録できないこと
    it "is invalid if password and password_confirmation are not same" do
      user = build(:user, password: "aaaaaaaa", password_confirmation: "bbbbbbbb")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end
    
    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "",)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end

    # 重複したemailが存在すること
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password][0]).to include("は7文字以上で入力してくださ")
    end
  end

  describe 'user#create' do
    # ticketが空では登録できないこと
    it "is invalid without a ticket" do
      user = build(:user, ticket: nil)
      user.valid?
      expect(user.errors[:ticket]).to include("を入力してください")
    end
  end

  describe 'adviser#create' do
    it "is valid with a name, email, password, icon, profile, adviser, area_id" do
      user = build(:adviser)
      expect(user).to be_valid
    end

    # ticketが空では登録できないこと
    it "is invalid without a area" do
      user = build(:adviser, area: nil)
      user.valid?
      expect(user.errors[:area]).to include("を入力してください")
    end

    # ticketが空では登録できないこと
    it "is invalid with less than 6 schedules" do
      user = build(:adviser,     schedules: [
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil)
      ])
      user.valid?
      expect(user.errors[:schedules]).to include("は7文字以上で入力してください")
    end

    # ticketが空では登録できないこと
    it "is invalid with more than 8 schedules" do
      user = build(:adviser,     schedules: [
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil),
        FactoryBot.build(:schedule, user: nil)
      ])
      user.valid?
      expect(user.errors[:schedules]).to include("は7文字以内で入力してください")
    end
  end
end