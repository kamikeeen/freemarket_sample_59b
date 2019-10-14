require 'rails_helper'

describe ItemsController do
  let(:user) { create(:user) }

  describe 'DELETE destroy' do

    context 'can delete' do
      it 'item status is selling' do
        login user
        item = create(:item1, user_id: user.id, status: "selling")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(-1)
      end

      it "redirect to listings_mypage_path" do
        login user
        item = create(:item1, user_id: user.id, status: "selling")
        delete :destroy, params: { id: item.id }, session: {}
        expect(response).to redirect_to listings_mypage_path
      end
    end

    context 'can not delete' do
      it 'item status is not selling' do
        login user
        item = create(:item1, user_id: user.id, status: "contract")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(0)
      end

      it 'item.user_id is not current_user.id' do
        login user
        another_user = create(:user)
        item = create(:item1, user_id: another_user.id, status: "selling")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(0)
      end

      it "redirect to item_path" do
        login user
        item = create(:item1, user_id: user.id, status: "contract")
        delete :destroy, params: { id: item.id }
        expect(response).to redirect_to item_path(item.id)
      end
    end

  end
end