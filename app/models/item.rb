class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to_active_hash :prefecture
  belongs_to :brand, optional: true

  accepts_nested_attributes_for :images, reject_if: :reject_images, allow_destroy: true

  enum damage: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage_side: [:exhibitor, :purchaser]
  enum arrival: [:soon, :few_days, :about_week]
  enum delivery_method: [:undecide, :rakurakumercari, :yu_mail, :leter_pack, :nurmal_post, :kuroneko, :yu_pack, :click_post, :yu_packet]
  enum status: [:selling, :contract, :sent, :arrived]

  validates :name,  presence: true,
                    length: { maximum: 40 }

  validates :price, presence: true,
                    numericality:{only_integer: true,
                                  greater_than_or_equal_to: 300,
                                  less_than_or_equal_to: 9999999}

  validates :text,  presence: true,
                    length: { maximum: 1000 }
  
  
  validates_presence_of :category
  validates_presence_of :damage
  validates_presence_of :postage_side
  validates_presence_of :delivery_method
  validates_presence_of :prefecture_id
  validates_presence_of :arrival
  validates_presence_of :status
  validates_presence_of :images
  validate :size_if_category_has_size, if: :category_id

  def size_if_category_has_size
    if category.size_id?
      errors.add(:size, "を選択してください") unless size
    end
  end


  def self.limit_delivery_methods_i18n
    delivery_methods_i18n.slice(:undecide, :yu_mail, :kuroneko, :yu_pack)
  end

  def reject_images(attributes)
    exists = attributes[:id].present?
    empty = attributes[:name].blank? && attributes[:name_cache].blank?
    attributes.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end
end
