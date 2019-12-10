class Area < ApplicationRecord
  has_many :areas_merits
  has_many :merits, through: :areas_merits
end
