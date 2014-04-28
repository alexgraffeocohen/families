class AddSlugToFamily < ActiveRecord::Migration
  def change
    add_column :families, :name_slug, :string
  end
end
