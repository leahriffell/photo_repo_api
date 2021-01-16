class AddLatLongToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :latitude, :float
    add_column :trips, :longitude, :float
    rename_column :trips, :name, :destination
  end
end
