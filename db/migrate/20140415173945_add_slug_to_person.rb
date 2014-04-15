class AddSlugToPerson < ActiveRecord::Migration
  def change
    add_column :people, :permission_slug, :string
  end
end
