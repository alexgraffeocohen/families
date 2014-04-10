class ChangePermissionAlbum < ActiveRecord::Migration
  def change
    rename_column :albums, :permission, :permissions
    change_column :albums, :permissions, :string
  end
end
