class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])

    @product_list ||= @category.internal_products
      .includes(:product)
      .includes(:variety)
      .includes(:presentation)
      .where("products.active = ? ", true)
      .where("internal_products.active = ? ", true)
      .where('price > 0')
      .order(featured: :desc)
      .order('products.order asc')
      .order('varieties.name_es asc')
      .order('presentations.size asc')

    @selected_subcategory ||= nil
    @selected_brand ||= nil
    @brands ||= Brand.where(active: true)
      .where(id: @category.products.distinct.pluck(:brand_id))
    @subcategory_list = @category.subcategories.where(active: true)
  end
end
