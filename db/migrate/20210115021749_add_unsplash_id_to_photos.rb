class AddUnsplashIdToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :unsplash_id, :string, null: true
  end
end
