FactoryBot.define do
  factory :image do
    name {File.open("#{Rails.root}/public/uploads/image/name/1/item01.jpg")}

    item
  end
end