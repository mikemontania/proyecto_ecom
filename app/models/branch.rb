class Branch < ApplicationRecord
  has_one_attached :image

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
