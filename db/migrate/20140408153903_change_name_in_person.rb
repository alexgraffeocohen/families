class ChangeNameInPerson < ActiveRecord::Migration
  def change
    add_column :people, :last_name, :string
    rename_column :people, :name, :first_name
  end
end
