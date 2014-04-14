class AddPermissionsToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :permissions, :string
  end
end
