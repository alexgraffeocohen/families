class RemoveDateFromAlbum < ActiveRecord::Migration
  def change
    remove_column :albums, :date, :datetime
  end
end
