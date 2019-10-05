require 'rails_helper'

describe Address do
  describe '#create' do

    it "正しい内容なら問題なく通過するかの確認" do
      address = FactoryBot.build(:address)
      expect(address).to be_valid
    end


    #以下かく項目が空では登録できないことを確認

    it "familynameが空では登録できない" do
      address = FactoryBot.build(:address, familyname: "")
      address.valid?
      expect(address.errors[:familyname]).to include("を入力してください")
    end

    it "firstnameが空では登録できない" do
      address = FactoryBot.build(:address, firstname: "")
      address.valid?
      expect(address.errors[:firstname]).to include("を入力してください")
    end

    it "familyname_kanaが空では登録できない" do
      address = FactoryBot.build(:address, familyname_kana: "")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("を入力してください")
    end

    it "firstname_kanaが空では登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("を入力してください")
    end

    it "zip_codeが空では登録できない" do
      address = FactoryBot.build(:address, zip_code: "")
      address.valid?
      expect(address.errors[:zip_code]).to include("を入力してください")
    end

    it "prefecture_idが空では登録できない" do
      address = FactoryBot.build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "cityが空では登録できない" do
      address = FactoryBot.build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "address_lineが空では登録できない" do
      address = FactoryBot.build(:address, address_line: "")
      address.valid?
      expect(address.errors[:address_line]).to include("を入力してください")
    end

    it "building_nameは空でも登録できる" do
      address = FactoryBot.build(:address, building_name: "")
      expect(address).to be_valid
    end

    it "phone_numberは空でも登録できる" do
      address = FactoryBot.build(:address, phone_number: "")
      expect(address).to be_valid
    end


    #familyname, firstnameのチェック
    it "familynameが36文字以上だと登録できない" do
      address = FactoryBot.build(:address, familyname: "123456789012345678901234567890123456")
      address.valid?
      expect(address.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "familynameが35文字以下なら登録できる" do
      address = FactoryBot.build(:address, familyname: "12345678901234567890123456789012345")
      expect(address).to be_valid
    end

    it "firstnameが36文字以上だと登録できない" do
      address = FactoryBot.build(:address, familyname: "123456789012345678901234567890123456")
      address.valid?
      expect(address.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "firstnameが35文字以下なら登録できる" do
      address = FactoryBot.build(:address, familyname: "12345678901234567890123456789012345")
      expect(address).to be_valid
    end


    #familyname_kanaのチェック

    it "familyname_kanaが36文字以上だと登録できない" do
      address = FactoryBot.build(:address, familyname: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      address.valid?
      expect(address.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "familyname_kanaが35文字以下なら登録できる" do
      address = FactoryBot.build(:address, familyname: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      expect(address).to be_valid
    end

    it "familyname_kanaは全角カタカナのみなら登録できる" do
      address = FactoryBot.build(:address, familyname_kana: "テスト")
      expect(address).to be_valid
    end

    it "familyname_kanaは半角ｶﾀｶﾅだと登録できない" do
      address = FactoryBot.build(:address, familyname_kana: "ﾃｽﾄ")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaはひらがなだと登録できない" do
      address = FactoryBot.build(:address, familyname_kana: "てすと")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは数字だと登録できない" do
      address = FactoryBot.build(:address, familyname_kana: "12345")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは英字だと登録できない" do
      address = FactoryBot.build(:address, familyname_kana: "abcde")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（ひらがな含む）" do
      address = FactoryBot.build(:address, familyname_kana: "テストあ")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（半角ｶﾀｶﾅ含む）" do
      address = FactoryBot.build(:address, familyname_kana: "テストｱ")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（数字含む）" do
      address = FactoryBot.build(:address, familyname_kana: "テスト1")
      address.valid?
      expect(address.errors[:familyname_kana]).to include("が不適切です")
    end


    #firstname_kanaのチェック

    it "firstname_kanaが36文字以上だと登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("は35文字以内で入力してください")
    end

    it "firstname_kanaが35文字以下なら登録できる" do
      address = FactoryBot.build(:address, firstname_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      expect(address).to be_valid
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（英字含む）" do
      address = FactoryBot.build(:address, firstname_kana: "テストa")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみなら登録できる" do
      address = FactoryBot.build(:address, firstname_kana: "テスト")
      expect(address).to be_valid
    end

    it "firstname_kanaは半角ｶﾀｶﾅだと登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "ﾃｽﾄ")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaはひらがなだと登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "てすと")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは数字だと登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "12345")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは英字だと登録できない" do
      address = FactoryBot.build(:address, firstname_kana: "abcde")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（ひらがな含む）" do
      address = FactoryBot.build(:address, firstname_kana: "テストあ")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（半角ｶﾀｶﾅ含む）" do
      address = FactoryBot.build(:address, firstname_kana: "テストｱ")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（数字含む）" do
      address = FactoryBot.build(:address, firstname_kana: "テスト1")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（英字含む）" do
      address = FactoryBot.build(:address, firstname_kana: "テストa")
      address.valid?
      expect(address.errors[:firstname_kana]).to include("が不適切です")
    end
    

    #zip_codeのチェック

    it "zip_codeは正しいフォーマットであれば登録できる" do
      address = FactoryBot.build(:address, zip_code: "123-4567")
      expect(address).to be_valid
    end

    it "zip_codeはハイフンが無いと登録できない" do
      address = FactoryBot.build(:address, zip_code: "1234567")
      address.valid?
      expect(address.errors[:zip_code]).to include("が不適切です")
    end

    it "zip_codeは4ケタ-3ケタでは登録できない" do
      address = FactoryBot.build(:address, zip_code: "1234-567")
      address.valid?
      expect(address.errors[:zip_code]).to include("が不適切です")
    end

    it "zip_codeは数字以外が含まれていると登録できない" do
      address = FactoryBot.build(:address, zip_code: "123-456a")
      address.valid?
      expect(address.errors[:zip_code]).to include("が不適切です")
    end


    #phone_numberのチェック
    
    it "phone_numberは規定のフォーマットの時のみ登録できる" do
      user = FactoryBot.build(:user, phone_number: "09012345678")
      expect(user).to be_valid
    end

    it "phone_numberは全角数字でも登録できる" do
      user = FactoryBot.build(:user, phone_number: "０９０１２３４５６７８")
      expect(user).to be_valid
    end

    it "phone_numberはハイフンが含まれていても登録できる（半角）" do
      user = FactoryBot.build(:user, phone_number: "090-1234-5678")
      expect(user).to be_valid
    end

    it "phone_numberはハイフンが含まれていても登録できる（全角）" do
      user = FactoryBot.build(:user, phone_number: "０９０-１２３４-５６７８")
      expect(user).to be_valid
    end

    it "phone_numberのハイフンの位置が異なると登録できない" do
      user = FactoryBot.build(:user, phone_number: "090-123456-78")
      user.valid?
      expect(user.errors[:phone_number]).to include("が不適切です")
    end

    it "phone_numberのハイフン一つだけでは登録できない" do
      user = FactoryBot.build(:user, phone_number: "090-12345678")
      user.valid?
      expect(user.errors[:phone_number]).to include("が不適切です")
    end

    it "phone_numberの先頭3ケタが070, 080, 090以外は登録できない" do
      user = FactoryBot.build(:user, phone_number: "06012345678")
      user.valid?
      expect(user.errors[:phone_number]).to include("が不適切です")
    end

    it "phone_numberに数字以外が含まれていると登録できない(英字)" do
      user = FactoryBot.build(:user, phone_number: "0091234567a")
      user.valid?
      expect(user.errors[:phone_number]).to include("が不適切です")
    end

    it "phone_numberに数字以外が含まれていると登録できない(全角文字)" do
      user = FactoryBot.build(:user, phone_number: "0091234567あ")
      user.valid?
      expect(user.errors[:phone_number]).to include("が不適切です")
    end

  end
end