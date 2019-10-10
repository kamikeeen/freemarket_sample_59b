FactoryBot.define do
  factory :image do
    sequence(:id) {|n| n}
    name                  {File.open("#{Rails.root}/public/uploads/image/name/1/item01.jpg")}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end