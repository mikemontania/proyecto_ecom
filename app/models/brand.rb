class Brand < ApplicationRecord
  has_many :products
  has_many :internal_products, through: :products
  has_one_attached :logo

  extend FriendlyId
  friendly_id :name, use: :slugged
end
