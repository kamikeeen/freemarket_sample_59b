require 'rails_helper'

describe '#index' do
  context 'can display' do
    it 'is exist with category' do
      expect(build(:category)).to be
    end
  end
end

describe '#show' do
  context 'can display' do
    it 'is exist with category' do
      expect(build(:category)).to be
    end
    it 'is exist with image' do
      expect(build(:image)).to be
    end
    it 'is exist with item-name' do
      expect(build(:item, price: nil, user_id: nil, category_id: nil, damage: nil, postage_side: nil, delivery_method: nil, prefecture_id: nil, arrival: nil, text: nil, size_id: nil)).to be
    end
    it 'is exist with item-price' do
      expect(build(:item, name: nil, user_id: nil, category_id: nil, damage: nil, postage_side: nil, delivery_method: nil, prefecture_id: nil, arrival: nil, text: nil, size_id: nil)).to be
    end
    it 'is exist with item-name and item-price' do
      expect(build(:item, user_id: nil, category_id: nil, damage: nil, postage_side: nil, delivery_method: nil, prefecture_id: nil, arrival: nil, text: nil, size_id: nil)).to be
    end
  end
end