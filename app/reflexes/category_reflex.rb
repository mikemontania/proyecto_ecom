# frozen_string_literal: true

class CategoryReflex < ApplicationReflex
  def filter_subcategory
    category_id = @element.dataset['category-id']
    subcategory_id = @element.value.to_i
    brand_id = @element.dataset['brand-id']

    @category = Category.find(category_id)

    if subcategory_id.zero?
      @selected_subcategory = nil
      @selected_brand = Brand.find(brand_id.to_i) if brand_id.present?

      @product_list = @category.internal_products
                               .includes(:product)
                               .includes(:variety)
                               .includes(:presentation)
                               .where('price > 0')
                               .where('internal_products.active = ?', true)
                               .where('products.active = ?', true)
                               .order('internal_products.featured desc')
                               .order('products.order asc')
                               .order('varieties.name_es asc')
                               .order('presentations.size asc')

      @brands = Brand.where(active: true)
                     .where(
                       id: @category.products
                                    .distinct
                                    .pluck(:brand_id)
                     )
    else

      @selected_subcategory = Subcategory.find(subcategory_id.to_i)
      @selected_brand = Brand.find(brand_id.to_i) if brand_id.present?

      #Analizar este Query, aqui está el error.
      @product_list = @category.internal_products
                               .includes(:product)
                               .includes(:variety)
                               .includes(:presentation)
                               .where(format('products.subcategory_id = %<id>i', id: @selected_subcategory.id))
                               .where('internal_products.price > 0')
                               .where('internal_products.active = ?', true)
                               .where('products.active = ?', true)
                               .order('internal_products.featured desc')
                               .order('products.order asc')
                               .order('varieties.name_es asc')
                               .order('presentations.size asc')

      @brands = Brand.where(active: true)
                     .where(
                       id: @category.products
                                    .where(subcategory_id: @selected_subcategory.id)
                                    .distinct
                                    .pluck(:brand_id)
                     )

    end

    if @selected_brand.present?

      if @brands.detect { |b| b == @selected_brand }
        @product_list = @product_list
                        .where(format('products.brand_id = %<id>i', id: @selected_brand.id))
                        .where('price > 0')
                        .order(featured: :desc)
      else
        @selected_brand = nil
      end

    end
  end

  def filter_brand
    category_id = @element.dataset['category-id']
    subcategory_id = @element.dataset['subcategory-id']

    brand_id = @element.value.to_i
    @selected_subcategory = Subcategory.find(subcategory_id.to_i) if subcategory_id.present?
    @category = Category.find(category_id)

    if brand_id.zero?
      @selected_brand = nil
      @product_list = @category.internal_products
                               .includes(:product)
                               .includes(:variety)
                               .includes(:presentation)
                               .where(active: true)
                               .where('price > 0')
                               .order(featured: :desc)
                               .order('products.order asc')
                               .order('varieties.name_es asc')
                               .order('presentations.size asc')

    else
      @selected_brand = Brand.find(brand_id.to_i)
      @product_list = @category.internal_products
                               .includes(:product)
                               .includes(:variety)
                               .includes(:presentation)
                               .where(active: true)
                               .where(format('products.brand_id = %<id>i', id: @selected_brand.id))
                               .where('price > 0')
                               .order(featured: :desc)
                               .order('products.order asc')
                               .order('varieties.name_es asc')
                               .order('presentations.size asc')

    end

    if @selected_subcategory.present?
      @product_list = @product_list
                      .where(format('products.subcategory_id = %<id>i', id: @selected_subcategory.id))
                      .where('price > 0')
                      .order(featured: :desc)

    end
  end
end
