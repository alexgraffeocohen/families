class AddOwnerToEvent < ActiveRecord::Migration
  def change
    add_column :events, :person_id, :integer
  end
end
