class Merit < ApplicationRecord
  has_many :schools_merits
  has_many :schools, through: :schools_merits

  validates :title, presence: :true
end
