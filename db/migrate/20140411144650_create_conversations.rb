class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :title

      t.timestamps
    end
  end
end
