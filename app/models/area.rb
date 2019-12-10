class Area < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  has_many :areas_merits
  has_many :merits, through: :areas_merits
end
