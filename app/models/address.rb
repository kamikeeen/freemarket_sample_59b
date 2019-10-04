class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  validates :familyname,              presence: true, length: {maximum: 35}
  validates :firstname,               presence: true, length: {maximum: 35}
  validates :familyname_kana,         presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana,          presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :zip_code,                presence: true
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true
  validates :address_line,            presence: true

end
