class CreatePhotoTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_trips do |t|
      t.references :photo, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
