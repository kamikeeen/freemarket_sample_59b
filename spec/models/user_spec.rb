require 'rails_helper'

describe User do
  describe '#create' do

    it "正しい内容なら問題なく通過するかの確認" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end


    #以下かく項目が空では登録できないことを確認

    it "nicknameが空では登録できない" do
      user = FactoryBot.build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailが空では登録できない" do
      user = FactoryBot.build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordが空では登録できない" do
      user = FactoryBot.build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "password_confirmationが空では登録できない" do
      user = FactoryBot.build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    it "familynameが空では登録できない" do
      user = FactoryBot.build(:user, familyname: "")
      user.valid?
      expect(user.errors[:familyname]).to include("を入力してください")
    end

    it "firstnameが空では登録できない" do
      user = FactoryBot.build(:user, firstname: "")
      user.valid?
      expect(user.errors[:firstname]).to include("を入力してください")
    end

    it "familyname_kanaが空では登録できない" do
      user = FactoryBot.build(:user, familyname_kana: "")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("を入力してください")
    end

    it "firstname_kanaが空では登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("を入力してください")
    end

    it "phone_numberが空では登録できない" do
      user = FactoryBot.build(:user, phone_number: "")
      user.valid?
      expect(user.errors[:phone_number]).to include("を入力してください")
    end


    #以下各項目に関しての詳細なvalidationの確認

    #nicknameのチェック

    it "nicknameが21文字以上だと登録できない" do
      user = FactoryBot.build(:user, nickname: "123456789012345678901")
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    it "nicknameが20文字以下なら登録できる" do
      user = FactoryBot.build(:user, nickname: "12345678901234567890")
      expect(user).to be_valid
    end


    #emailのチェック

    it "重複したemailが存在する場合登録できない" do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "emailのフォーマットが不適切だと登録できない（@がない）" do
      user = FactoryBot.build(:user, email: "test.test")
      user.valid?
      expect(user.errors[:email]).to include("が不適切です")
    end

    it "emailのフォーマットが不適切だと登録できない（@はあるが.以下がない）" do
      user = FactoryBot.build(:user, email: "test@test")
      user.valid?
      expect(user.errors[:email]).to include("が不適切です")
    end

    it "emailのフォーマットは適切だが全角が含まれていると登録できない" do
      user = FactoryBot.build(:user, email: "テスト@test.test")
      user.valid?
      expect(user.errors[:email]).to include("が不適切です")
    end

    #passwordのチェック
    it "passwordが7文字以上だと登録できる" do
      user = FactoryBot.build(:user, password: "test123")
      expect(user).to be_valid
    end

    it "passwordが6文字以下だと登録できない" do
      user = FactoryBot.build(:user, password: "test12")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "passwordが数字のみだと登録できない" do
      user = FactoryBot.build(:user, password: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("が不適切です")
    end

    it "passwordが英字のみだと登録できない" do
      user = FactoryBot.build(:user, password: "abcdefg")
      user.valid?
      expect(user.errors[:password]).to include("が不適切です")
    end

    it "passwordが129文字以上だと登録できない" do
      user = FactoryBot.build(:user, password: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678a")
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end

    it "passwordが128文字以内だと登録できる" do
      user = FactoryBot.build(:user, password: "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567a", password_confirmation: "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567a")
      expect(user).to be_valid
    end

    #familyname, firstnameのチェック
    it "familynameが36文字以上だと登録できない" do
      user = FactoryBot.build(:user, familyname: "123456789012345678901234567890123456")
      user.valid?
      expect(user.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "familynameが35文字以下なら登録できる" do
      user = FactoryBot.build(:user, familyname: "12345678901234567890123456789012345")
      expect(user).to be_valid
    end

    it "firstnameが36文字以上だと登録できない" do
      user = FactoryBot.build(:user, familyname: "123456789012345678901234567890123456")
      user.valid?
      expect(user.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "firstnameが35文字以下なら登録できる" do
      user = FactoryBot.build(:user, familyname: "12345678901234567890123456789012345")
      expect(user).to be_valid
    end


    #familyname_kanaのチェック

    it "familyname_kanaが36文字以上だと登録できない" do
      user = FactoryBot.build(:user, familyname: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      user.valid?
      expect(user.errors[:familyname]).to include("は35文字以内で入力してください")
    end

    it "familyname_kanaが35文字以下なら登録できる" do
      user = FactoryBot.build(:user, familyname: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      expect(user).to be_valid
    end

    it "familyname_kanaは全角カタカナのみなら登録できる" do
      user = FactoryBot.build(:user, familyname_kana: "テスト")
      expect(user).to be_valid
    end

    it "familyname_kanaは半角ｶﾀｶﾅだと登録できない" do
      user = FactoryBot.build(:user, familyname_kana: "ﾃｽﾄ")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaはひらがなだと登録できない" do
      user = FactoryBot.build(:user, familyname_kana: "てすと")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは数字だと登録できない" do
      user = FactoryBot.build(:user, familyname_kana: "12345")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは英字だと登録できない" do
      user = FactoryBot.build(:user, familyname_kana: "abcde")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（ひらがな含む）" do
      user = FactoryBot.build(:user, familyname_kana: "テストあ")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（半角ｶﾀｶﾅ含む）" do
      user = FactoryBot.build(:user, familyname_kana: "テストｱ")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end

    it "familyname_kanaは全角カタカナのみ出ないと登録できない（数字含む）" do
      user = FactoryBot.build(:user, familyname_kana: "テスト1")
      user.valid?
      expect(user.errors[:familyname_kana]).to include("が不適切です")
    end


    #firstname_kanaのチェック

    it "firstname_kanaが36文字以上だと登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は35文字以内で入力してください")
    end

    it "firstname_kanaが35文字以下なら登録できる" do
      user = FactoryBot.build(:user, firstname_kana: "アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア")
      expect(user).to be_valid
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（英字含む）" do
      user = FactoryBot.build(:user, firstname_kana: "テストa")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみなら登録できる" do
      user = FactoryBot.build(:user, firstname_kana: "テスト")
      expect(user).to be_valid
    end

    it "firstname_kanaは半角ｶﾀｶﾅだと登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "ﾃｽﾄ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaはひらがなだと登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "てすと")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは数字だと登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "12345")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは英字だと登録できない" do
      user = FactoryBot.build(:user, firstname_kana: "abcde")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（ひらがな含む）" do
      user = FactoryBot.build(:user, firstname_kana: "テストあ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（半角ｶﾀｶﾅ含む）" do
      user = FactoryBot.build(:user, firstname_kana: "テストｱ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（数字含む）" do
      user = FactoryBot.build(:user, firstname_kana: "テスト1")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
    end

    it "firstname_kanaは全角カタカナのみ出ないと登録できない（英字含む）" do
      user = FactoryBot.build(:user, firstname_kana: "テストa")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("が不適切です")
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