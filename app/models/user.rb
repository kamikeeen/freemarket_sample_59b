class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:facebook, :google_oauth2]


  belongs_to_active_hash :prefecture
  has_many :addresses
  accepts_nested_attributes_for :addresses

  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX =              /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_KANA_REGEX =                  /\A[ァ-ヶー－]+\z/
  VALID_PHONE_NUMBER_REGEX =          /(070|080|090)\d{8}|(070|080|090)-\d{4}-\d{4}|(０７０|０８０|０９０)[０-９]{8}|(０７０|０８０|０９０)-[０-９]{4}-[０-９]{4}/

  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation,   presence: true
  validates :familyname,              presence: true, length: {maximum: 35}
  validates :firstname,               presence: true, length: {maximum: 35}
  validates :familyname_kana,         presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana,          presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :phone_number,            presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }

  
  has_many :items
  has_many :sns_credentials, dependent: :destroy

  has_one :card
        
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present? #sns登録のみ完了してるユーザー
      user = User.where(id: snscredential.user_id).first
      unless user.present? #ユーザーが存在しないなら
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email
        )
      end
      # snscredentialのid,uid,provider,user_idを持ってもう一度callbacksコントローラへ
      sns = snscredential
    else #sns登録 未
      user = User.where(email: auth.info.email).first
      if user.present? #会員登録 済
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
        )
      else #会員登録 未
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email
        )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider
        )
      end
    end
    # hashでsnsのidを返り値として保持しておく
    return { user: user , sns: sns }
  end
end
