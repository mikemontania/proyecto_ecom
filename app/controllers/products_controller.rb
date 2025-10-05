class ProductsController < ApplicationController
  def show
    product_id = params[:id]
    pres_id = params[:p]
    var_id = params[:v]

    @product ||= InternalProduct.where(internal_code: product_id).where(active: true).where(presentation_id: pres_id)
                                .where(variety_id: var_id)
                                .first
    if !@product.present?
      redirect_back(fallback_location: root_path, alert: "El producto seleccionado no está disponible por el momento.")
    end

  end


  def product_information
    internal_product_id = params[:id]
    productInformation = InternalProduct.find(internal_product_id)
    information = {}

    if productInformation.present?
      current_date_string = Time.now.strftime('%Y%m%d')
      product_discount = ProductDiscount.where(internal_product: internal_product_id)
                                      .where([' min_quantity <= ? AND max_quantity >= ?', 1, 1])
                                      .where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string])
                                      .first
      information['item_id'] = productInformation.id
      information['item_name'] = productInformation.full_name('es')
      information['discount'] = product_discount.present? ? product_discount.discount_rate : 0
      information['item_brand'] = 'Cavallaro'
      information['item_category'] = productInformation.category.name
      information['item_variant'] = productInformation.variety.name
      information['price'] = productInformation.price
      information['currency'] = 'PYG'
      information['quantity'] = 1
    end

    information.to_json

    respond_to do |format|
      format.json { render json: information }
    end
  end
end
