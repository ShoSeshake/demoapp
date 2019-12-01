class School < ApplicationRecord
  has_many :users
  has_many :schools_merits
  has_many :merits, through: :schools_merits

  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :location

  enum location: [:center, :north, :east, :south, :west]

  validates  :name, :description, :location, presence: :true
end
