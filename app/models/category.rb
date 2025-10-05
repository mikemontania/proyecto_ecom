class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :products, -> { where(active: true) }
  has_many :internal_products, through: :products

  has_one_attached :icon

  extend FriendlyId
  friendly_id :name_es, use: :slugged

  def name(lang = 'es')
    case lang
    when 'en'
      name_en
    when 'pt'
      name_br
    else
      name_es
    end
  end
end
