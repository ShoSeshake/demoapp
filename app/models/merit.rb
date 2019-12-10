class Merit < ApplicationRecord
  has_many :areas_merits
  has_many :areas, through: :areas_merits

  validates :title, presence: :true
end
