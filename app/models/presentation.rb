class Presentation < ApplicationRecord
  has_many :internal_products

  has_one_attached :icon

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
