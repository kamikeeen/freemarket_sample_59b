class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  VALID_KANA_REGEX =                  /\A[ァ-ヶー－]+\z/
  VALID_ZIP_CODE_REGEX =              /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_NUMBER_REGEX =          /(070|080|090)\d{8}|(070|080|090)-\d{4}-\d{4}|(０７０|０８０|０９０)[０-９]{8}|(０７０|０８０|０９０)-[０-９]{4}-[０-９]{4}/

  validates :familyname,              presence: true, length: {maximum: 35}
  validates :firstname,               presence: true, length: {maximum: 35}
  validates :familyname_kana,         presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :firstname_kana,          presence: true, length: {maximum: 35}, format: { with: VALID_KANA_REGEX }
  validates :zip_code,                presence: true, format: { with: VALID_ZIP_CODE_REGEX }
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true
  validates :address_line,            presence: true
  validates :phone_number,            allow_blank: true, format: { with: VALID_PHONE_NUMBER_REGEX }

end
