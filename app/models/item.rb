class Item < ApplicationRecord
  has_many :images

  enum status: [:excerent, :great, :good, :normal, :bad, :worse]
end
