FactoryBot.define do

  factory :item, class: Item do
    name                  {Faker::Lorem.characters(number: 1..40)}
    damage                {Faker::Number.within(range: 0..5)}
    postage_side          {Faker::Number.within(range: 0..1)}
    delivery_method       {Faker::Number.within(range: 0..8)}
    prefecture_id         {Faker::Number.within(range: 1..47)}
    arrival               {Faker::Number.within(range: 0..2)}
    status                {Faker::Number.within(range: 0..3)}
    price                 {Faker::Number.within(range: 300..9999999)}
    text                  {Faker::Lorem.characters(number: 1..1000)}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    size
    user
    category
    after(:build) do |item|
      item.images << FactoryBot.build(:image)
    end
  end

end

FactoryBot.define do

  factory :item1, class: Item do
    name                  {Faker::Lorem.characters(number: 1..40)}
    damage                {Faker::Number.within(range: 0..5)}
    postage_side          {Faker::Number.within(range: 0..1)}
    delivery_method       {Faker::Number.within(range: 0..8)}
    prefecture_id         {Faker::Number.within(range: 1..47)}
    arrival               {Faker::Number.within(range: 0..2)}
    status                {Faker::Number.within(range: 0..3)}
    price                 {Faker::Number.within(range: 300..9999999)}
    text                  {Faker::Lorem.characters(number: 1..1000)}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    size
    user
    category
    after(:build) do |item|
      item.images << FactoryBot.build(:image)
    end
  end
  
end