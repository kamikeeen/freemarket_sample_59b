class Item < ApplicationRecord
  has_many :images

  enum status: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage: [:exhibitor_side, :purchaser_side]
  enum arrival: [:soon, :few_days, :about_week]
  enum delivery_method: [:undecide, :rakurakumercari, :yu_mail, :leter_pack, :nurmal_post, :kuroneko, :yu_pack, :click_post, :yu_packet]

  def self.limit_delivery_methods
    delivery_methods_i18n.slice(:undecide, :yu_mail, :kuroneko, :yu_pack).invert
  end
end
