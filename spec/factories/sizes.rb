FactoryBot.define do
  factory :size do
    name {Faker::Ancient.god}
    ancestry {"1"}

    # sequence(:name) {|n| "Parents Size"}

    # factory :size_child do |c|
    #   f.sequence(:name) {|n| "Child Size"}
    #   f.parent FactoryBot.create(:category)
    # end

  end
end