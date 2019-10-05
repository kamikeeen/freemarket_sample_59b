require 'rails_helper'
describe Item do
  describe '#create' do
    let(:category) {create(:category)}
    let(:user) {create(:user)}
    let(:size) {create(:size)}

    it "is invalid without a name" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid name length over 40" do
      item = build(:item, name: Faker::Lorem.characters(number: 41))
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "is valid name length less than 40" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, name: Faker::String.random(length: 1..40))
      expect(item).to be_valid
    end

    it "is invalid without a text" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, text: nil)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "is invalid text length over 1000" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, text: Faker::Lorem.characters(number: 1001))
      item.valid?
      expect(item.errors[:text]).to include("は1000文字以内で入力してください")
    end

    it "is valid text length less than 1000" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, text: Faker::String.random(length: 1..1000))
      expect(item).to be_valid
    end
    
    it "is invalid without a price" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "is invalid price based string" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: Faker::Lorem.characters)
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

    it "is invalid price 0 to 299" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: Faker::Number.within(range: 0..299))
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end

    it "is invalid price over 10000000" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: Faker::Number.number(digits: 8))
      item.valid?
      expect(item.errors[:price]).to include("は9999999以下の値にしてください")
    end

    it "is valid price 300 to 9999999" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: Faker::Number.within(range: 300..9999999))
    end

    it "is invalid price integer" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, price: Faker::Number.decimal(l_digits: 1))
      item.valid?
      expect(item.errors[:price]).to include("は整数で入力してください")
    end

    it "is invalid without a category_id" do
      item = build(:item, user_id: user.id, category_id: nil)
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "is invalid without a damage" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, damage: nil)
      item.valid?
      expect(item.errors[:damage]).to include("を入力してください")
    end

    it "is invalid without a postage_side" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, postage_side: nil)
      item.valid?
      expect(item.errors[:postage_side]).to include("を入力してください")
    end

    it "is invalid without a delivery_method" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, delivery_method: nil)
      item.valid?
      expect(item.errors[:delivery_method]).to include("を入力してください")
    end

    it "is invalid without a prefecture_id" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is invalid without a arrival" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, arrival: nil)
      item.valid?
      expect(item.errors[:arrival]).to include("を入力してください")
    end

    it "is invalid without a status" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: size.id, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("を入力してください")
    end

    it "is invalid without a images" do
      item = build(:item, user_id: user.id, category_id: category.id)
      item.images.clear
      item.valid?
      expect(item.errors[:images]).to include("を入力してください")
    end

    it "is invalid without a size_id at category has size" do
      item = build(:item, user_id: user.id, category_id: category.id, size_id: nil)
      item.valid?
      expect(item.errors[:size]).to include("を選択してください")
    end
  end
end