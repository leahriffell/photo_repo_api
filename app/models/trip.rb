class Trip < ApplicationRecord
  belongs_to :user
  has_many :photo_trips, dependent: :destroy
  has_many :photos, through: :photo_trips

  validates :destination, presence: true

  def self.top_trips(limit)
    Trip.select('COUNT(destination) AS num_saved_trips, destination')
        .group('destination')
        .order('num_saved_trips DESC, destination')
        .limit(limit)
  end
end
