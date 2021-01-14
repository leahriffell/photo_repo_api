class AddTraveledToToTrips < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :traveled_to?, :boolean
  end
end
