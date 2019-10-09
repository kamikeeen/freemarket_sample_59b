require 'rails_helper'

describe ItemsController do
  let(:user) { create(:user) }


  describe 'DELETE destroy' do

    context 'can delete' do
      it 'item status is selling' do
        login user
        item = create(:item, user_id: user.id, status: "selling")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(-1)
      end

      it "redirect to listings_mypage_path" do
        login user
        item = create(:item, user_id: user.id, status: "selling")
        delete :destroy, params: { id: item.id }, session: {}
        expect(response).to redirect_to listings_mypage_path
      end
    end

    context 'can not delete' do
      it 'item status is not selling' do
        login user
        item = create(:item, user_id: user.id, status: "contract")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(0)
      end

      it 'item.user_id is not current_user.id' do
        login user
        another_user = create(:user)
        item = create(:item, user_id: another_user.id, status: "selling")
        expect do
          delete :destroy, params: { id: item.id }, session: {}
        end.to change(Item, :count).by(0)
      end

      it "redirect to item_path" do
        login user
        item = create(:item, user_id: user.id, status: "contract")
        delete :destroy, params: { id: item.id }
        expect(response).to redirect_to item_path(item.id)
      end
    end

  end


  let!(:items) {create_list(:item, 10)}

  describe 'GET #index' do

    before do
      get :index
    end

    it "assigns @itemsCategory1, @itemsCategory2, @itemsCategory3, @itemsCategory4, @CategoryName1, @CategoryName2, @CategoryName3, @CategoryName4" do

      category1 = 1
      expect(assigns(:itemsCategory1)).to match(Item.where(category_id: [Category.find(category1).descendant_ids]).sort{|a, b| b.id <=> a.id}.values_at(0..9))
      category = Category.find(category1)
      expect(assigns(:CategoryName1)).to match(category.name)

      category2 = 200
      expect(assigns(:itemsCategory2)).to match(Item.where(category_id: [Category.find(category2).descendant_ids]).sort{|a, b| b.id <=> a.id}.values_at(0..9))
      category = Category.find(category2)
      expect(assigns(:CategoryName2)).to match(category.name)

      category3 = 680
      expect(assigns(:itemsCategory3)).to match(Item.where(category_id: [Category.find(category3).descendant_ids]).sort{|a, b| b.id <=> a.id}.values_at(0..9))
      category = Category.find(category3)
      expect(assigns(:CategoryName3)).to match(category.name)

      category4 = 893
      expect(assigns(:itemsCategory4)).to match(Item.where(category_id: [Category.find(category4).descendant_ids]).sort{|a, b| b.id <=> a.id}.values_at(0..9))
      category = Category.find(category4)
      expect(assigns(:CategoryName4)).to match(category.name)
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end

  end
end
