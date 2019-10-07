FactoryBot.define do
  factory :category do
    sequence(:id) {|n| 1325 + n}
    sequence(:name) {Faker::Demographic.race}
    ancestry {"1/2"}

  end
end