class Item < ApplicationRecord
  has_many :images

  enum status: [:excerent, :great, :good, :normal, :bad, :worse]
  enum postage: [:exhibitor, :purchaser]
end
