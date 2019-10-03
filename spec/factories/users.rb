FactoryBot.define do
  factory :user do
    email {Faker::Internet.free_email}
    encrypted_password {Faker::Internet.password(min_length: 8)}
  end
end