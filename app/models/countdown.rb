class Countdown < ApplicationRecord
  has_one_attached :image_desktop
  has_one_attached :image_mobile

  validates :image_desktop, attached: true, content_type: ['image/png', 'image/jpeg'],
    size: { between: 1.kilobyte..500.kilobyte, message: 'Tamaño de imagen permitido: de 1 a 500kb, Imágenes de tipo: PNG o JPG.' }

  validates :image_mobile, attached: true, content_type: ['image/png', 'image/jpeg'],
    size: { between: 1.kilobyte..500.kilobyte, message: 'Tamaño de imagen permitido: de 1 a 500kb, Imágenes de tipo: PNG o JPG.' }
end
