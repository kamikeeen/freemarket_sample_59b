require 'rails_helper'

describe SignupsController do
  describe 'GET #index' do
    it "リクエストに成功するか確認" do
      get :index
      response.should be_success
    end
    it "正しいViewが読み込まれるか確認 :index" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #registration' do
    it "リクエストに成功するか確認" do
      get :registration
      response.should be_success
    end
    it "指定クラスのインスタンスかつ未保存レコードであることを検証" do
      get :registration
      expect(assigns(:user)).to be_a_new(User)
    end
    it "正しいViewが読み込まれるか確認 :regstration" do
      get :registration
      expect(response).to render_template :registration
    end
  end

  describe 'GET #sms_confirmation' do
    before do
      controller.stub(:validates_registration).and_return(true)
    end
    it "リクエストに成功するか確認" do
      get :sms_confirmation
      response.should be_success
    end
    it "指定クラスのインスタンスかつ未保存レコードであることを検証" do
      get :sms_confirmation
      expect(assigns(:user)).to be_a_new(User)
    end
    it "正しいViewが読み込まれるか確認 :sms_confirmation" do
      get :sms_confirmation
      expect(response).to render_template :sms_confirmation
    end
  end

  describe 'GET #sms' do
    before do
      controller.stub(:validates_sms_confirmation).and_return(true)
    end
    it "リクエストに成功するか確認" do
      get :sms
      response.should be_success
    end
    it "正しいViewが読み込まれるか確認 :sms " do
      get :sms
      expect(response).to render_template :sms
    end
  end

  describe 'GET address' do
    it "リクエストに成功するか確認" do
      get :address
      response.should be_success
    end
    it "指定クラスのインスタンスかつ未保存レコードであることを検証 :user" do
      get :address
      expect(assigns(:user)).to be_a_new(User)
    end
    it "指定クラスのインスタンスかつ未保存レコードであることを検証 :address" do
      get :address
      expect(assigns(:address)).to be_a_new(Address)
    end
    # it "指定クラスのインスタンスかつ未保存レコードであることを検証 :@user.addresses" do
    #   get :address
    #   expect(assigns(:user)).to be_a_new(Address)
    # end
    it "正しいViewが読み込まれるか確認 :address " do
      get :address
      expect(response).to render_template :address
    end
  end

  describe 'GET payment' do
    before do
      controller.stub(:validates_address).and_return(true)
    end
    it "リクエストに成功するか確認" do
      get :payment
      response.should be_success
    end
    it "指定クラスのインスタンスかつ未保存レコードであることを検証 :user" do
      get :payment
      expect(assigns(:user)).to be_a_new(User)
    end
    it "正しいViewが読み込まれるか確認 :payment " do
      get :payment
      expect(response).to render_template :payment
    end
  end

  describe 'GET end' do
    it "リクエストに成功するか確認" do
      get :end
      response.should be_success
    end
    it "正しいViewが読み込まれるか確認 :end " do
      get :end
      expect(response).to render_template :end
    end
  end

  describe 'POSt create' do
    context "正常な値" do
      before do
        controller.session[:nickname] = "test"
        controller.session[:email] = "test@gmail.com"
        controller.session[:password] = "test123"
        controller.session[:password_confirmation] = "test123"
        controller.session[:familyname] = "test"
        controller.session[:firstname] = "test"
        controller.session[:familyname_kana] = "テスト"
        controller.session[:firstname_kana] = "テスト"
        controller.session["birthday(1i)"] = "2019"
        controller.session["birthday(2i)"] = "10"
        controller.session["birthday(3i)"] = "6"
        controller.session[:phone_number] = "09011111111"
        controller.session[:family_name] = "test"
        controller.session[:first_name] = "test"
        controller.session[:family_name_kana] = "テスト"
        controller.session[:first_name_kana] = "テスト"
        controller.session[:zip_code] = "111-1111"
        controller.session[:prefecture_id] = "1"
        controller.session[:city] = "test"
        controller.session[:address_line] = "test"
        controller.session[:building_name] = "test"
        controller.session[:phonenumber] = "09099999999"
      end
      it "新規ユーザーを登録できる。" do
        expect{post :create}.to change(User, :count).by(1)
      end
      it "登録されたユーザーの詳細画面へリダイレクトされる。" do
        post :create
        expect(response).to redirect_to end_signups_path
      end
    end
    context "正常な値ではない時" do
      before do
        controller.session[:nickname] = "test"
        controller.session[:email] = "test@gmail.com"
        # passwordを不正な値に変更している
        controller.session[:password] = "test"
        controller.session[:password_confirmation] = "test123"
        controller.session[:familyname] = "test"
        controller.session[:firstname] = "test"
        controller.session[:familyname_kana] = "テスト"
        controller.session[:firstname_kana] = "テスト"
        controller.session["birthday(1i)"] = "2019"
        controller.session["birthday(2i)"] = "10"
        controller.session["birthday(3i)"] = "6"
        controller.session[:phone_number] = "09011111111"
        controller.session[:family_name] = "test"
        controller.session[:first_name] = "test"
        controller.session[:family_name_kana] = "テスト"
        controller.session[:first_name_kana] = "テスト"
        controller.session[:zip_code] = "111-1111"
        controller.session[:prefecture_id] = "1"
        controller.session[:city] = "test"
        controller.session[:address_line] = "test"
        controller.session[:building_name] = "test"
        controller.session[:phonenumber] = "09099999999"
      end
      it "登録されない。" do
        expect{post :create}.to change(User, :count).by(0)
      end

      it "payment画面へ戻される。" do
        post :create
        expect(response).to render_template :payment
      end
    end
  end


end