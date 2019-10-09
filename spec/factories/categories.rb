FactoryBot.define do
  factory :category do
    sequence(:id)         {|n| 1325 + n}
    name                  {Faker::Lorem.characters}
    ancestry              {"1"}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    size_id               {1}
  end
end