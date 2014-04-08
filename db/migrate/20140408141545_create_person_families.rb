class CreatePersonFamilies < ActiveRecord::Migration
  def change
    create_table :person_families do |t|
      t.integer :person_id
      t.integer :family_id

      t.timestamps
    end
  end
end
