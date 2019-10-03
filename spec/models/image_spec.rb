require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#index' do
    context 'can display' do
      it 'is valid with image' do
        expect(build(:image)).to be_valid
      end
    end

    context 'can not display' do
      it 'is invalid without item_id' do
        image = build(:image, item_id: nil)
        image.valid?
        expect(image).not_to be_valid
      end
    end
  end
end