class ChangeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :adress, :address_line
  end
end
