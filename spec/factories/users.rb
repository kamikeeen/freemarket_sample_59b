FactoryBot.define do
  factory :user do
    sequence(:id) {|n| 1 + n}
    sequence(:email)  {|n| Faker::Internet.free_email + n.to_s}
    password  {11111111}
    encrypted_password  {11111111}
  end
end