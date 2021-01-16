class AddLatLongToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :latitude, :integer
    add_column :trips, :longitude, :integer
    rename_column :trips, :name, :destination
  end
end
