class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  VALID_KANA_REGEX =                  /\A[ァ-ヶー－]+\z/
  VALID_ZIP_CODE_REGEX =              /\A\d{3}[-]\d{4}\z/

  validates :familyname,              presence: true, length: {maximum: 35}
  validates :firstname,               presence: true, length: {maximum: 35}
  validates :familyname_kana,         presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana,          presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :zip_code,                presence: true, format: { with: VALID_KANA_REGEX }
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true
  validates :address_line,            presence: true

end
