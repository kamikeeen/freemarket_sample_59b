require 'rails_helper'

describe SnsCredential do
  describe '#create' do
    context "重複の確認" do
      it "uidとproviderの組み合わせがすでにあれば登録ができない" do
        sns_credential = create(:sns_credential)
        another_sns_credential = build(:sns_credential, uid: sns_credential.uid, provider: sns_credential.provider)
        another_sns_credential.valid?
        expect(another_sns_credential.errors[:uid]).to include("既に登録があるため登録できません")
      end
      it "uidが一致していてもproviderが違えば登録できる" do
        sns_credential = create(:sns_credential)
        another_sns_credential = build(:sns_credential, uid: "23232323", provider: sns_credential.provider)
        another_sns_credential.valid?
        expect(another_sns_credential).to be_valid
      end
      it "providerが一致していてもuidが違えば登録できる" do
        sns_credential = create(:sns_credential)
        another_sns_credential = build(:sns_credential, uid: sns_credential.uid, provider: "Google")
        another_sns_credential.valid?
        expect(another_sns_credential).to be_valid
      end
    end
    context "nilの確認" do
      it 'uidとproviderがnilなら登録できない' do
        sns_credential = build(:sns_credential, uid: nil, provider: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:uid]).to include('を入力してください')
      end
      it 'uidがnilなら登録できない' do
        sns_credential = build(:sns_credential, uid: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:uid]).to include('を入力してください')
      end
      it 'providerがnilなら登録できない' do
        sns_credential = build(:sns_credential, provider: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:provider]).to include('を入力してください')
      end
      it 'user_idがnilなら登録できない' do
        sns_credential = build(:sns_credential, user_id: nil)
        sns_credential.valid?
        expect(sns_credential.errors[:user_id]).to include('を入力してください')
      end
      it '全て入力されていれば登録できる' do
        sns_credential = build(:sns_credential)
        expect(sns_credential).to be_valid
      end
    end
  end
end