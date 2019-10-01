class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user, foreign_key: true, null:false
    add_reference :items, :category, foreign_key: true, null: false
    add_column     :items, :damage, :integer, null: false
    add_column     :items, :postage_side, :integer, null: false
    add_column     :items, :delivery_method, :integer, null:false
    add_column     :items, :prefecture_id, :integer, null:false
    add_column     :items, :arrival, :integer, null: false
    add_column     :items, :text, :text, null: false
  end
end
