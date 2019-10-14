FactoryBot.define do
  factory :user do
    nickname                {"test"}
    email                   {Faker::Internet.email}
    password                {"test123"}
    password_confirmation   {"test123"}
    familyname              {"test"}
    firstname               {"test"}
    familyname_kana         {"テスト"}
    firstname_kana          {"テスト"}
    birthday                {"2019-10-5"}
    phone_number            {"09099999999"}
  end
end
