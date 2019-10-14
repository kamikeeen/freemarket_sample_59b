FactoryBot.define do
  factory :user, class: User  do
    nickname                {"test"}
    email                   {Faker::Internet.email}
    password                {"test123"}
    password_confirmation   {"test123"}
    familyname              {"test"}
    firstname               {"test"}
    familyname_kana         {"テスト"}
    firstname_kana          {"テスト"}
    birthday                {"2019-10-5"}
    phone_number            {"09012345678"}
  end
  factory :another_user, class: User do
    nickname                {"test2"}
    email                   {Faker::Internet.email}
    password                {"test321"}
    password_confirmation   {"test321"}
    familyname              {"test2"}
    firstname               {"test2"}
    familyname_kana         {"テストトト"}
    firstname_kana          {"テストトト"}
    birthday                {"2019-10-9"}
    phone_number            {"08088888888"}
  end
end
