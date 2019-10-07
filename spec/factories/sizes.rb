FactoryBot.define do
  factory :size do
    sequence(:id)         {|n| 145 + n}
    name                  {Faker::Lorem.characters}
    ancestry              {"1"}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end