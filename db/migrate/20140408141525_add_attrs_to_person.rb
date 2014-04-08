class AddAttrsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :name, :string
    add_column :people, :age, :integer
    add_column :people, :birthday, :datetime
    add_column :people, :location, :string
    add_column :people, :mother_id, :integer
    add_column :people, :father_id, :integer
    add_column :people, :admin, :integer
    add_column :people, :spouse_id, :integer
  end
end
