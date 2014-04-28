class ChangeContentInEvent < ActiveRecord::Migration
  def change
    rename_column :events, :content, :description
  end
end
