class InternalProduct < ApplicationRecord
  has_one_attached :image

  belongs_to :product
  belongs_to :presentation
  belongs_to :variety
  has_one :category, through: :product
  has_many :cart_items
  has_many :product_discounts


  # Suspendido por el momento SLUG.
  #extend FriendlyId
  #friendly_id :name, use: :slugged

  def name
    "#{internal_code}_#{product.name('es')}"
  end

  def full_name(lang)
    "#{product.name(lang)} #{variety.name(lang)} #{presentation.name(lang)}"
  end

  def attributes_name(lang)
    "#{variety.name(lang)} #{presentation.name(lang)}"
  end

  def description(lang)
    product.description(lang)
  end

  def properties(lang)
    product.properties(lang)
  end

  def uses(lang)
    product.uses(lang)
  end

  def parent_name(lang)
    product.name(lang)
  end

  def image_path
    ActiveStorage::Blob.service.path_for(image.key) if image.attached?
  end

  def parent_childrens
    product.internal_products.where(active: true)
  end

  def related_products
    product.category.internal_products.where(active: true).where.not(product_id: product_id).limit(4)
  end

  def self.search(q, lang)
    product_list =  includes(:product)
                    .includes(:variety)
                    .includes(:presentation)
                    .where('products.active = ?', true)
                    .where(active: true)
                    .where('price > 0')
                    .order(featured: :desc)
                    .order('products.order asc')
                    .order('varieties.name_es asc')
                    .order('presentations.size asc')
                    .select { |p| p.full_name(lang).downcase.include? q.downcase }
  end

  def has_discount
    current_date_string = Time.now.strftime('%Y%m%d')

    product_discounts.where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string]).count > 0
  end

  def discounted_unit_price
    discount_rate = active_discount_rate
    discounted_price = discount_rate.positive? ? price - ((price * discount_rate) / 100).round : price
    discounted_price
  end

  def active_discount_rate
    current_date_string = Time.now.strftime('%Y%m%d')
    if product_discounts.where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string])
                        .count
                        .positive?

      product_discounts.where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string])
                       .first
                       .discount_rate
    else
      0
    end

  #private

  end
end
