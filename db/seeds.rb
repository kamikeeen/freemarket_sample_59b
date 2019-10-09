# password = "11111111"
# User.create(
#   email: "hogehoge@fuga.ne.jp",
#   password: password,
#   password_confirmation: password
# )
  
require "csv"
# CSV.foreach('db/csv/完成サイズ一覧.csv', headers: true) do |row|
#   Size.create(
#     name: row['name'],
#     ancestry: row['ancestry']
#   )
# end

# CSV.foreach('db/csv/カテゴリー一覧(size).csv', headers: true) do |row|
#   Category.create(
#     name: row['Name'],
#     ancestry: row['ancestry'],
#     size_id: row['size_id']
#   )
# end

CSV.foreach('db/csv/レディース ブランド一覧 .csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/メンズ ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/ベビー・キッズ ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/インテリア・住まい・雑貨 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/キッチン・食器 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/時計 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/コスメ・香水・美容 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/テレビゲーム ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/スポーツ・レジャー ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/スマートフォン・携帯電話 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/バイク ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/楽器 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/自動車パーツ ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/食品 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/国内自動車本体 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

CSV.foreach('db/csv/外国自動車本体 ブランド一覧.csv', headers: true) do |row|
  Brand.create(name: row['name'])
end

