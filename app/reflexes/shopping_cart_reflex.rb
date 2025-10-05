# frozen_string_literal: true

class ShoppingCartReflex < ApplicationReflex

  def add_item
    cart_id = @element.dataset['cart_id'].to_i

    category_id = @element.dataset['category-id'].to_i
    subcategory_id = @element.dataset['selected-subcategory'].to_i
    brand_id = @element.dataset['selected-brand'].to_i

    internal_product_id = @element.dataset['internal_product_id']

    @shopping_cart = if cart_id.zero?
                       ShoppingCart.shopping_cart_factory(nil, nil)
                     else
                       ShoppingCart.find(cart_id)
                     end

    session[:shopping_cart] = @shopping_cart.session_uuid

    internal_product = InternalProduct.find(internal_product_id)
    @shopping_cart.add_item(internal_product)

    @toastr = 'Producto agregado al carrito'

    # Filter behavior
    @category = Category.find(category_id) if category_id != 0
    @selected_brand = Brand.find(brand_id) if brand_id != 0
    @selected_subcategory = Subcategory.find(subcategory_id) if subcategory_id != 0

    if @category

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

      if @selected_subcategory.present?
        @product_list = @product_list
          .where(format('products.subcategory_id = %<id>i', id: @selected_subcategory.id))

        @brands = Brand.where(active: true)
          .where(
            id: @category.products
          .where(subcategory_id: @selected_subcategory.id)
          .distinct
          .pluck(:brand_id)
          )
      else
        @brands = Brand.where(active: true)
          .where(
            id: @category.products
          .distinct
          .pluck(:brand_id)
          )
      end

      if @selected_brand.present?
        if @brands.detect { |b| b == @selected_brand }
          @product_list = @product_list
            .where(format('products.brand_id = %<id>i', id: @selected_brand.id))

        else
          @selected_brand = nil
        end
      end
    end
  end

  def remove_item
    cart_id = @element.dataset['cart_id']
    internal_product_id = @element.dataset['internal_product_id']

    @shopping_cart = ShoppingCart.find(cart_id)
    internal_product = InternalProduct.find(internal_product_id)
    @shopping_cart.remove_item(internal_product)

    @toastr = 'Producto eliminado del carrito'
  end

  def clear_cart
    cart_id = @element.dataset['cart_id']
    @shopping_cart = ShoppingCart.find(cart_id)
    @shopping_cart.clear

    @toastr = 'Carrito vacio'
  end
end
