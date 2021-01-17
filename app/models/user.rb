class User < ApplicationRecord
  has_secure_password
  has_many :trips, dependent: :destroy
  has_many :photo_trips, through: :trips
  has_many :photos, through: :photo_trips

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
end
