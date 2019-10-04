FactoryBot.define do
  factory :category do
    name {Faker::Demographic.race}
    ancestry {"1/21"}

  end
end