FactoryBot.define do
  factory :size do
    sequence(:id) {|n| 145 + n}
    name  {"teamb"}
    ancestry {"1"}
  end
end