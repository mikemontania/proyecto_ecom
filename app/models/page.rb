class Page < ApplicationRecord
  has_one_attached :icon
  has_rich_text :content_es
  has_rich_text :content_en
  has_rich_text :content_br

  extend FriendlyId
  friendly_id :title, use: :slugged

  def title(lang = 'es')
    case lang
    when 'en'
      title_en
    when 'pt'
      title_br
    else
      title_es
    end
  end

  def content(lang = 'es')
    case lang
    when 'en'
      content_en
    when 'pt'
      content_br
    else
      content_es
    end
  end
end
