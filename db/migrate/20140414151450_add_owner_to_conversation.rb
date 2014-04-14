class AddOwnerToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :person_id, :integer
  end
end
