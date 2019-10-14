require 'rails_helper'

describe ItemsController do
  

  describe 'GET #index' do
  let!(:images) {create_list(:image, 41)}
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
  
  before do
    @another_user = FactoryBot.create(:another_user)
    @item = FactoryBot.create(:item)
    @user = @item.user
  end
  describe "GET #edit" do
    context "出品ユーザー" do
      it "アクセス成功" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to be_success
      end
      
      it "アクセスステータス２００" do
        sign_in @user
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "200"
      end
    end
    context "出品者以外のユーザー" do
      
      it "アクセス失敗" do
        sign_in @another_user
        get :edit, params: {id: @item}
        expect(response).to_not be_success
      end
      
      it "トップページへリダイレクト" do
        sign_in @another_user
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
    context "ログインしていない" do
      
      it "アクセス失敗" do
        get :edit, params: {id: @item.id}
        expect(response).to have_http_status "302"
      end
      
      it "トップページへ戻る" do
        get :edit, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "出品ユーザー更新成功" do
      
      it "更新成功" do
        sign_in @user
        item_params = {text: "テストテストテスト"}
        patch :update, params: {id: @item.id, item: item_params}
        expect(@item.reload.text).to eq "テストテストテスト"
      end
      
      it "更新後、アイテム詳細ページへ" do
        sign_in @user
        item_params = {text: "テストテストテスト"}
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to redirect_to item_path
      end
    end
    context "出品ユーザー更新失敗" do
      
      it "テキストnilなら更新できない" do
        sign_in @user
        item_params = {text: nil}
        patch :update, params: {id: @item.id, item: item_params}
        expect(@item.reload.text).to eq @item.text
      end
      
      it "更新失敗したら編集画面に戻る" do
        sign_in @user
        item_params = {text: nil}
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to render_template :edit
      end
    end
    context "出品ユーザー以外" do
      
      it "アクセス失敗" do
        sign_in @another_user
        patch :update, params: {id: @item.id}
        expect(response).to_not be_success
      end
      
      it "トップページへ戻る" do
        sign_in @another_user
        patch :update, params: {id: @item.id}
        expect(response).to redirect_to root_path
      end
    end
    context "ログインしていない" do
      
      it "トップページへ戻る" do
        item_params = {
          text: "テストさん",
          user_id: 1
        }
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to_not be_success
      end
      
      it "トップページへ戻る" do
        item_params = {
          text: "テストさん",
          user_id: 1
        }
        patch :update, params: {id: @item.id, item: item_params}
        expect(response).to redirect_to root_path
      end
    end
  end
end

