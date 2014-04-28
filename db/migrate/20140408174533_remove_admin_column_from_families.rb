class RemoveAdminColumnFromFamilies < ActiveRecord::Migration
  def change
    remove_column :families, :admin_id
  end
end
