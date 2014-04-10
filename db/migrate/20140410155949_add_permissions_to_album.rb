class AddPermissionsToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :permission, :integer
  end
end
