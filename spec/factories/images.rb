FactoryBot.define do
  factory :image do
    sequence(:id) {|n| n}
    name {File.open("#{Rails.root}/public/uploads/image/name/1/item01.jpg")}
  
    item

  end
end