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

  validates :nickname,                presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 6, maximum: 128}
  validates :password_confirmation,   presence: true, length: {minimum: 6, maximum: 128}
  validates :familyname,              presence: true
  validates :firstname,               presence: true
  validates :familyname_kana,         presence: true
  validates :firstname_kana,          presence: true
  validates :phone_number,            presence: true

end
