class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id
      t.timestamps
    end
    add_index :sns_credentials, [:provider, :uid], unique: true
  end
end
