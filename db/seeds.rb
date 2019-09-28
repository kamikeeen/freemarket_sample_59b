
# password = "kamiken7"
# User.create(
#   email: "ke.n-k.en@docomo.ne.jp",
#   password: password,
#   password_confirmation: password
#   )

require "csv"
CSV.foreach('db/完成カテゴリー一覧 .csv', headers: true) do |row|
  Category.create(
    name: row['Name'],
    ancestry: row['ancestry']
  )
end