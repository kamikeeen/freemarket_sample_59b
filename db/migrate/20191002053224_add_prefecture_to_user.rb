class AddPrefectureToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefecture_id, :integer, after: :zip_code
  end
end
