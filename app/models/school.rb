class School < ApplicationRecord
  has_many :users
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :location
end
