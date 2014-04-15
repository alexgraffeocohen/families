class AddPermissionsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :permissions, :string
  end
end
