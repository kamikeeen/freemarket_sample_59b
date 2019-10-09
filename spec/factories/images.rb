FactoryBot.define do
  factory :image do
    name                  {File.open("#{Rails.root}/public/images/test.jpg")}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end