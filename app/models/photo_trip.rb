class PhotoTrip < ApplicationRecord
  belongs_to :photo
  belongs_to :trip
end
