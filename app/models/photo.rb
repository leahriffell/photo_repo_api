class Photo < ApplicationRecord
  has_many :photo_trips, dependent: :destroy
  has_many :trips, through: :photo_trips

  validates :url, presence: true
end
