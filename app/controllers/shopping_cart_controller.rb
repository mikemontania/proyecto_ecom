class ShoppingCartController < ApplicationController
  before_action :retrieve_shopping_cart
  before_action :check_prices_update, only: %i[show]

  def add_item
    quantity = params[:quantity].to_i
    @shopping_cart.add_item internal_product, quantity

    @toastr = 'Producto agregado correctamente'

    respond_to do |format|
      format.html
      format.js
    end
  end

  def remove_item
    internal_product = InternalProduct.find(params[:id])
    quantity = params[:quantity].to_i
    @shopping_cart.remove_item internal_product, quantity

    @toastr = 'Producto eliminado correctamente'
  end

  def destroy_item
    item = CartItem.find(params[:id])
    item.destroy
    redirect_to shopping_cart_show_path, notice: 'Item eliminado correctamente.'
  end

  def clear
    @shopping_cart.clear
    redirect_to shopping_cart_show_path, notice: 'Todos los items fueron eliminados.'
  end

  def show
    if user_signed_in?
      if current_user.coupon_used == false && current_user.qr_link.present? && current_user.coupon_code.present?
        flash.now[:notice] = "<b>Recordatorio:</b> tienes un cupón disponible para utilizar, en tu perfil de usuario podrás encontrarlo.".html_safe
      end
    end
  end

  private
  def check_prices_update
    changed = false
    current_date_string = Time.now.strftime('%Y-%m-%d')

    if user_signed_in?
      current_user.shopping_cart.cart_items.each do |sc|
        get_product = InternalProduct.find(sc.internal_product_id)

        product_discount = ProductDiscount.where(internal_product_id: sc.internal_product_id)
          .where('min_quantity <= ? AND max_quantity >= ?', sc.quantity, sc.quantity)
          .where('begin_date <= ? AND end_date >= ?', current_date_string, current_date_string)
          .first

        if sc.calculate_totals
          changed = true
        end
      end

      if changed
        return redirect_to shopping_cart_show_path, notice: "Hubieron variaciones de precios en los productos que seleccionaste para tu compra."
      end
    end
  end

  def retrieve_shopping_cart
    @shopping_cart ||= ShoppingCart.shopping_cart_factory(user_signed_in? ? current_user : nil, session[:shopping_cart])

    set_session_cart_uuid

    @shopping_cart
  end

  def set_session_cart_uuid
    session[:shopping_cart] = @shopping_cart.session_uuid
  end
end
