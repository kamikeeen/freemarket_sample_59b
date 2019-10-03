class Item < ApplicationRecord
  has_many :images
  belongs_to :user
  belongs_to :category
  belongs_to :size, optional: true

  accepts_nested_attributes_for :images

  enum damage: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage_side: [:exhibitor, :purchaser]
  enum arrival: [:soon, :few_days, :about_week]
  enum delivery_method: [:undecide, :rakurakumercari, :yu_mail, :leter_pack, :nurmal_post, :kuroneko, :yu_pack, :click_post, :yu_packet]
  enum status: [:selling, :contract, :sent, :arrived]

  validates :name,  presence: true,
                    length: { maximum: 40 }

  validates :price, presence: true,
                    numericality:{only_interger: true,
                                  greater_than_or_equal_to: 300,
                                  less_than_or_equal_to: 9999999}

  validates :text,  presence: true,
                    length: { maximum: 1000 }

  validates_presence_of :category_id
  validates_presence_of :damage
  validates_presence_of :postage_side
  validates_presence_of :delivery_method
  validates_presence_of :prefecture_id
  validates_presence_of :arrival
  validates_presence_of :status
  validates_presence_of :images



  def self.limit_delivery_methods_i18n
    delivery_methods_i18n.slice(:undecide, :yu_mail, :kuroneko, :yu_pack)
  end
end
