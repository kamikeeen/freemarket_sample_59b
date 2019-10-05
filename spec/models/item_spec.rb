require 'rails_helper'
describe Item do
  describe '#create' do

    category = FactoryBot.create(:category)
    user = FactoryBot.create(:user)

    it "is invalid without a name" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid name length over 40" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, name: Faker::Lorem.characters(number: 41))
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "is invalid without a text" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, text: nil)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "is invalid text length over 1000" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, text: Faker::Lorem.characters(number: 1001))
      item.valid?
      expect(item.errors[:text]).to include("は1000文字以内で入力してください")
    end
    
    it "is invalid without a price" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "is invalid price based string" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, price: Faker::Lorem.characters)
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

    it "is invalid price 0 to 299" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, price: Faker::Number.within(range: 0..299))
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end

    it "is invalid price over 10000000" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, price: Faker::Number.number(digits: 8))
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値にしてください")
    end

    it "is invalid price seisuu" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, price: Faker::Number.decimal(l_digits: 1))
      item.valid?
      expect(item.errors[:price]).to include("は整数で入力してください")
    end

    it "is invalid without a category_id" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: nil)
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "is invalid without a damage" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, damage: nil)
      item.valid?
      expect(item.errors[:damage]).to include("を入力してください")
    end

    it "is invalid without a postage_side" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, postage_side: nil)
      item.valid?
      expect(item.errors[:postage_side]).to include("を入力してください")
    end

    it "is invalid without a delivery_method" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, delivery_method: nil)
      item.valid?
      expect(item.errors[:delivery_method]).to include("を入力してください")
    end

    it "is invalid without a prefecture_id" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is invalid without a arrival" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, arrival: nil)
      item.valid?
      expect(item.errors[:arrival]).to include("を入力してください")
    end

    it "is invalid without a status" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("を入力してください")
    end

    it "is invalid without a images" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id)
      item.images.clear
      item.valid?
      expect(item.errors[:images]).to include("を入力してください")
    end

    it "is invalid without a size_id at category has size" do
      item = FactoryBot.build(:item, user_id: user.id, category_id: category.id, size_id: nil)
      item.valid?
      expect(item.errors[:size]).to include("を選択してください")
    end
  end
end