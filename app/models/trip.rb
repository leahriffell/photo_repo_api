class Trip < ApplicationRecord
  belongs_to :user
  has_many :photo_trips, dependent: :destroy
  has_many :photos, through: :photo_trips

  validates :name, presence: true
end
