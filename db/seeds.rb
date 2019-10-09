password = "11111111"
User.create(
  email: "hogehoge@fuga.ne.jp",
  password: password,
  password_confirmation: password
)
  
require "csv"
CSV.foreach('db/完成サイズ一覧.csv', headers: true) do |row|
  Size.create(
    name: row['name'],
    ancestry: row['ancestry']
  )
end

CSV.foreach('db/カテゴリー一覧(size).csv', headers: true) do |row|
  Category.create(
    name: row['Name'],
    ancestry: row['ancestry'],
    size_id: row['size_id']
  )
end
