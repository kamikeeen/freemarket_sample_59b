FactoryBot.define do
  factory :item do
    sequence(:id)         {|n| n}
    name                  {Faker::Lorem.characters(number: 1..40)}
    damage                {Faker::Number.within(range: 0..5)}
    postage_side          {Faker::Number.within(range: 0..1)}
    delivery_method       {Faker::Number.within(range: 0..8)}
    prefecture_id         {Faker::Number.within(range: 1..47)}
    arrival               {Faker::Number.within(range: 0..2)}
    status                {Faker::Number.within(range: 0..3)}
    price                 {Faker::Number.within(range: 300..9999999)}
    text                  {Faker::Lorem.characters(number: 1..1000)}
    created_at            {Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    size
    sequence(:category_id, 0) { |n|
                          [2, 21, 43, 56, 62, 67, 78, 87, 95, 114,
                            201, 214, 238, 248, 257, 270, 276, 284, 293, 323,
                            681, 692, 698, 707, 722, 731, 747, 754, 758, 769,
                            894, 900, 909, 918, 926, 935, 944, 951, 965, 977,
                            1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090,
                            2, 21, 43, 56, 62, 67, 78, 87, 95, 114,
                            201, 214, 238, 248, 257, 270, 276, 284, 293, 323,
                            681, 692, 698, 707, 722, 731, 747, 754, 758, 769,
                            894, 900, 909, 918, 926, 935, 944, 951, 965, 977,
                            1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090,
                            2, 21, 43, 56, 62, 67, 78, 87, 95, 114,
                            201, 214, 238, 248, 257, 270, 276, 284, 293, 323,
                            681, 692, 698, 707, 722, 731, 747, 754, 758, 769,
                            894, 900, 909, 918, 926, 935, 944, 951, 965, 977,
                            1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090,
                            2, 21, 43, 56, 62, 67, 78, 87, 95, 114,
                            201, 214, 238, 248, 257, 270, 276, 284, 293, 323,
                            681, 692, 698, 707, 722, 731, 747, 754, 758, 769,
                            894, 900, 909, 918, 926, 935, 944, 951, 965, 977,
                            1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090][n - 1]}
    
    after(:build) do |item|
      item.images << FactoryBot.build(:image)
    end
    
    user
    category
    
  end
end