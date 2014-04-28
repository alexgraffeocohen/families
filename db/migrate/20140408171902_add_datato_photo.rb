class AddDatatoPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :data, :string
  end
end
