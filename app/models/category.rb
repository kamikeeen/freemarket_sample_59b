class Category < ApplicationRecord
  has_ancestry
  belongs_to :size, optional: true
  has_many :items
end
