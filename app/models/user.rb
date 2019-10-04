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
  VALID_PASSWORD_REGEX =              /\A[a-z0-9]+\z/i
  VALID_KANA_REGEX =                  /\A[ァ-ヶー－]+\z/

  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 7, maximum: 128}, format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation,   presence: true, length: {minimum: 7, maximum: 128}
  validates :familyname,              presence: true, length: {maximum: 35}
  validates :firstname,               presence: true, length: {maximum: 35}
  validates :familyname_kana,         presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana,          presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :phone_number,            presence: true, length: {maximum: 35}

end