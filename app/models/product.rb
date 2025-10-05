class Product < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :brand

  has_many :internal_products, inverse_of: :product
  has_many :varieties, through: :internal_products

  accepts_nested_attributes_for :internal_products, reject_if: :all_blank, allow_destroy: true

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

  def description(lang = 'es')
    case lang
    when 'en'
      description_en
    when 'pt'
      description_br
    else
      description_es
    end
  end

  def uses(lang = 'es')
    case lang
    when 'en'
      uses_en
    when 'pt'
      uses_br
    else
      uses_es
    end
  end

  def properties(lang = 'es')
    case lang
    when 'en'
      properties_en
    when 'pt'
      properties_br
    else
      properties_es
    end
  end
end
