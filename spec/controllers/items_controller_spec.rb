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
  


  let(:another_user){create(:another_user)}
  let(:item){create(:item)}
  let(:card){create(:card, user_id: item.user.id)}

  before do
    @user = item.user
  end


  describe "#show" do
    before do
      get :show, params: {id: item.id}
    end

    it "アクセス成功" do
      expect(response).to be_successful
    end
    
    it "アクセスステータス２００" do
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    context "ログインしている" do
      before do 
        login @user
        get :new
      end
      it "アクセス成功" do
        expect(response).to be_successful
      end
      
      it "アクセスステータス２００" do
        expect(response).to have_http_status "200"
      end
    end
    context "ログインしていない" do
      before do
        get :new
      end
      it "アクセス失敗" do
        expect(response).to_not be_successful
      end
      
      it "ログイン画面へリダイレクト" do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "#create" do
    let(:params) { { user_id: another_user.id, item: attributes_for(:item) } }
    context "ログインしている" do
      before do 
        login another_user
        subject{
        post :create,
        params: params
        }
      end
      it "アクセス成功" do
        expect(response).to be_successful
      end
      
      it "アクセスステータス２００" do
        expect(response).to have_http_status "200"
      end
    end
    context "ログインしていない" do
      before do
        post :create
        subject{
          post :create,
          params: params
          }
      end
      it "アクセス失敗" do
        expect(response).to_not be_successful
      end
      
      it "ログイン画面へリダイレクト" do
        expect(response).to redirect_to user_session_path
      end
    end
  end


  describe "#edit" do
    context "SOLDしていない" do
      before do 
        item.status = 0
      end
      context "出品ユーザー" do
        before do 
          login @user
          get :edit, params: {id: item.id}
        end
        it "アクセス成功" do
          expect(response).to be_successful
        end
        
        it "アクセスステータス２００" do
          expect(response).to have_http_status "200"
        end
      end
      context "出品者以外のユーザー" do
        before do 
          login another_user
          get :edit, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end
      context "ログインしていない" do
        before do 
          get :edit, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to have_http_status "302"
        end
        
        it "ログイン画面へリダイレクト" do
          expect(response).to redirect_to user_session_path
        end
      end
    end

    context "SOLDしている" do
      before do
        item.status = 1
      end
      context "出品ユーザー" do
        before do 
          login @user
          get :edit, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end
      context "出品者以外のユーザー" do
        before do 
          login another_user
          get :edit, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end
      context "ログインしていない" do
        before do 
          get :edit, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to have_http_status "302"
        end
        
        it "ログイン画面へリダイレクト" do
          expect(response).to redirect_to user_session_path
        end
      end
    end
  end

  describe "#update" do
    context "出品ユーザー更新成功" do
      before do 
        login @user
        item_params = {text: "テストテストテスト"}
        patch :update, params: {id: item.id, item: item_params}
      end

      it "更新成功" do
        expect(item.reload.text).to eq "テストテストテスト"
      end
      
      it "更新後、アイテム詳細ページへ" do
        expect(response).to redirect_to item_path
      end
    end
    context "出品ユーザー更新失敗" do
      before do
        login @user
        item_params = {text: nil}
        patch :update, params: {id: item.id, item: item_params}
      end
      it "テキストnilなら更新できない" do
        expect(item.reload.text).to eq item.text
      end
      
      it "更新失敗したら編集画面に戻る" do
        expect(response).to render_template :edit
      end
    end
    context "出品ユーザー以外" do
      before do
        login another_user
        item_params = {text: "テストテストテスト"}
        patch :update, params: {id: item.id, item: item_params}
      end

      it "アクセス失敗" do
        expect(response).to_not be_successful
      end
      
      it "商品詳細ページへ戻る" do
        expect(response).to redirect_to action: "show"
      end
    end
    context "ログインしていない" do
      before do
          item_params = {
            text: "テストさん",
            user_id: 1
          }
          patch :update, params: {id: item.id, item: item_params}
      end

      it "アクセス失敗" do
        expect(response).to_not be_successful
      end
      
      it "ログイン画面へリダイレクト" do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "#purchase" do
    context "SOLDしていない" do
      before do
        item.status = 0
      end
      context "出品者以外のユーザー" do
        before do
          login another_user
          get :purchase, params: {id: item.id}
        end
        it "アクセス成功" do
          expect(response).to be_successful
        end
        
        it "アクセスステータス２００" do
          expect(response).to have_http_status "200"
        end
      end

      context "出品のユーザー" do
        before do
          login @user
          get :purchase, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end
      context "ログインしていない" do
        before do
          get :purchase, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to have_http_status "302"
        end
        it "ログイン画面へリダイレクト" do
          expect(response).to redirect_to user_session_path
        end
      end
    end

    context "SOLDしている" do
      before do
        item.status = 1
      end
      context "出品者以外のユーザー" do
        before do
          login another_user
          get :purchase, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end

      context "出品のユーザー" do
        before do
          login @user
          get :purchase, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to_not be_successful
        end
        
        it "商品詳細ページへリダイレクト" do
          expect(response).to redirect_to action: "show"
        end
      end
      context "ログインしていない" do
        before do
          get :purchase, params: {id: item.id}
        end
        it "アクセス失敗" do
          expect(response).to have_http_status "302"
        end
        it "ログイン画面へリダイレクト" do
          expect(response).to redirect_to user_session_path
        end
      end
    end
  end


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
        expect(response).to redirect_to listings_mypage_path(user.id)
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

  # describe "#buy" do
  #   context "SOLDしていない" do
  #     before do
  #       item.status = 0
  #       # card.user_id = another_user.id
  #       # another_user.card = card
  #     end
  #     context "出品者以外のユーザー" do
  #       before do
  #         login another_user
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス成功" do
  #         expect(response).to be_successful
  #       end
        
  #       it "アクセスステータス２００" do
  #         expect(response).to have_http_status "200"
  #       end
  #     end

  #     context "出品のユーザー" do
  #       before do
  #         login @user
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス失敗" do
  #         expect(response).to_not be_successful
  #       end
        
  #       it "商品詳細ページへリダイレクト" do
  #         expect(response).to redirect_to action: "show"
  #       end
  #     end
  #     context "ログインしていない" do
  #       before do
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス失敗" do
  #         expect(response).to have_http_status "302"
  #       end
  #       it "ログイン画面へリダイレクト" do
  #         expect(response).to redirect_to user_session_path
  #       end
  #     end
  #   end

  #   context "SOLDしている" do
  #     before do
  #       item.status = 1
  #     end
  #     context "出品者以外のユーザー" do
  #       before do
  #         login another_user
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス失敗" do
  #         expect(response).to_not be_successful
  #       end
        
  #       it "商品詳細ページへリダイレクト" do
  #         expect(response).to redirect_to action: "show"
  #       end
  #     end

  #     context "出品のユーザー" do
  #       before do
  #         login @user
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス失敗" do
  #         expect(response).to_not be_successful
  #       end
        
  #       it "商品詳細ページへリダイレクト" do
  #         expect(response).to redirect_to action: "show"
  #       end
  #     end
  #     context "ログインしていない" do
  #       before do
  #         get :buy, params: {id: item.id}
  #       end
  #       it "アクセス失敗" do
  #         expect(response).to have_http_status "302"
  #       end
  #       it "ログイン画面へリダイレクト" do
  #         expect(response).to redirect_to user_session_path
  #       end
  #     end
  #   end
  # end

end
