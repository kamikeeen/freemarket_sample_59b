
require "csv"
CSV.foreach('db/完成カテゴリー一覧.csv', headers: true) do |row|
  Category.create(
    name: row['Name'],
    ancestry: row['ancestry']
  )
end