FactoryBot.define do
  factory :item do
    name {Faker::Book.title}
    price {Faker::Number.between(from: 300, to: 9999999)}
    damage {Faker::Number.between(from: 0, to: 5)}
    postage_side {Faker::Number.between(from: 0, to: 1)}
    delivery_method {Faker::Number.between(from: 0, to: 8)}
    prefecture_id {1}
    arrival {Faker::Number.between(from: 0, to: 2)}
    text {Faker::Quote.famous_last_words}

    user
    category
    size
  end
end