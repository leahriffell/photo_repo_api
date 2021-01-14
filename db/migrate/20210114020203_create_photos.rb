class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :url, index: { unique: true }
      t.string :artist_name
      t.string :artist_profile
      t.boolean :user_uploaded?

      t.timestamps
    end
  end
end
