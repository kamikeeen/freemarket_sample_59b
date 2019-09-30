class Item < ApplicationRecord
  has_many :images

  enum status: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage: [:exhibitor_side, :purchaser_side]
  enum arrival: [:soon, :few_days, :about_week]
end
