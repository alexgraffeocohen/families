class RemoveUrlFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :image_url, :string
  end
end
