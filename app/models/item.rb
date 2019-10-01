class Item < ApplicationRecord
  has_many :images

  enum damage: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage_side: [:exhibitor, :purchaser]
  enum arrival: [:soon, :few_days, :about_week]
  enum delivery_method: [:undecide, :rakurakumercari, :yu_mail, :leter_pack, :nurmal_post, :kuroneko, :yu_pack, :click_post, :yu_packet]

  def self.limit_delivery_methods_i18n
    delivery_methods_i18n.slice(:undecide, :yu_mail, :kuroneko, :yu_pack)
  end
end
