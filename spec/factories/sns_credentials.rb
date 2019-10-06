FactoryBot.define do
  factory :sns_credential do
    uid {"1234567890"}
    provider {"facebook"}
    user_id {1}
  end
end