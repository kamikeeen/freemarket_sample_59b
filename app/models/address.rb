class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true

  validates :familyname,              presence: true
  validates :firstname,               presence: true
  validates :familyname_kana,         presence: true
  validates :firstname_kana,          presence: true
  validates :zip_code,                presence: true
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true
  validates :address_line,            presence: true

end
