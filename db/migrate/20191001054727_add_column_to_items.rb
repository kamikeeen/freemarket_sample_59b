class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user, foreign_key: true, null:false
    add_reference :items, :category, foreign_key: true, null: false
    add_column     :items, :damage, :string, null: false
    add_column     :items, :postage_side, :string, null: false
    add_column     :items, :delivery_method, :string, null:false
    add_column     :items, :prefecture_id, :integer, null:false
    add_column     :items, :arrival, :string, null: false
    add_column     :items, :price, :integer, null: false
    add_column     :items, :text, :text, null: false
  end
end
