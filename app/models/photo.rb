class Photo < ApplicationRecord
  has_many :photo_trips, dependent: :destroy
  has_many :trips, through: :photo_trips
  has_one_attached :user_photo
end
