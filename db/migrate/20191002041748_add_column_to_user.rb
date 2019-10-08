class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, after: :id
    add_column :users, :familyname, :string, null: false, after: :nickname
    add_column :users, :firstname, :string, null: false, after: :familyname
    add_column :users, :familyname_kana, :string, null: false, after: :firstname
    add_column :users, :firstname_kana, :string, null: false, after: :familyname_kana
    add_column :users, :birthday, :date, null: false, after: :firstname_kana
    add_column :users, :zip_code, :string, after: :birthday
    add_column :users, :city, :string, after: :zip_code
    add_column :users, :adress, :string, after: :city
    add_column :users, :phone_number, :integer, unique: true, after: :adress
    add_column :users, :profile, :text, after: :phone_number
  end
end
