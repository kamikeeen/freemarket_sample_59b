class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

end