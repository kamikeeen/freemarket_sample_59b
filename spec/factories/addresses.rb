FactoryBot.define do

  factory :address do
    user_id                 {"1"}
    familyname              {"test"}
    firstname               {"test"}
    familyname_kana         {"テスト"}
    firstname_kana          {"テスト"}
    zip_code                {"111-1111"}
    prefecture_id           {"1"}
    city                    {"test"}
    address_line            {"test"}
    building_name           {"test"}
    phone_number            {"09099999999"}
  end

end

