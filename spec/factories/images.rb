FactoryBot.define do
  factory :image do
    name {File.open("#{Rails.root}/public/uploads/image/name/1/item01.jpg")}

    association :item

  end
end