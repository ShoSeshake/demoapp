class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    mount_uploader :icon, ImageUploader
    mount_uploader :background_image, ImageUploader

    has_many :chats
    has_many :chat_reviews
    has_many :blogs,                 dependent: :destroy
    has_many :schedules,              dependent: :destroy

    belongs_to :school, optional: true

    accepts_nested_attributes_for :schedules

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :password, length: { minimum: 7, maximum: 128}
    validates :password_confirmation, length: { minimum: 7, maximum: 128}
    validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :name, :email, :password, :password_confirmation, :profile, :icon, presence: true
    validates :name, :email, :profile, :icon, presence: true, on: :update, unless: :encrypted_password_changed?
    validates :ticket, presence: true, unless: :adviser?
    validates :school, presence: true, if: :adviser?
    validates :schedules, length: { minimum: 7, maximum: 7}, if: :adviser?

end
