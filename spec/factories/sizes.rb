FactoryBot.define do
  factory :size do
    name                  {Faker::Lorem.characters}
    ancestry              {"1"}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end