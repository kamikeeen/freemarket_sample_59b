class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :familyname, null: false
      t.string :firstname, null: false
      t.string :familyname_kana, null: false
      t.string :firstname_kana, null: false
      t.string :zip_code, null: false
      t.integer :prefecture_id, null:false
      t.string :city, null: false
      t.string :address_line, null: false
      t.string :building_name
      t.integer :phone_number

      t.timestamps
    end
  end
end