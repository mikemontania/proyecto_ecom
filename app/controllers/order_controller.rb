class OrderController < ApplicationController
  before_action :set_order, only: %i[status confirm check_order greeting history_detail repeat_order check_prices_update]
  before_action :check_order, only: %i[status]
  before_action :check_prices_update

  def new
    if params[:cupon].present?
      #Chequear si el cupon está aun disponible.
      url = "#{ENV['ERP_SERVICE_CUPON_URL']}/search"
      token = ENV['ERP_SERVICE_TOKEN']

      service_response = Faraday.get(url, {token:token, keyword: params[:cupon]})
      response_data = JSON.parse(service_response.body)

      if response_data.empty?
        redirect_to shopping_cart_show_path, alert: "El cupon ingresado no existe."
      elsif !response_data.empty? && response_data[0]["activo"] == false
        redirect_to shopping_cart_show_path, alert: "El cupon ingresado ya está vencido o fue utilizado"
      else
        @cupon = response_data[0]
      end
    end

    if user_signed_in?

      minimum_purchase = Setting.all.first.minimum_purchase

      if current_user.shopping_cart.net_total_amount < minimum_purchase
        redirect_to shopping_cart_show_path,
          alert: "El valor de compra mínimo es de #{ActionController::Base.helpers.number_to_currency(minimum_purchase, unit: 'GS', format: '%n %u', precision: 0, delimiter: '.')}. Agrega más productos al carrito."
      end

      current_user.orders.where(status: :open).destroy_all

      last_order = Order.where(user: current_user).last

      if @cupon.present? && @cupon["descuento"] > 0
        @order = Order.new(
          user: current_user,
          status: :open,
          tax_number_type: if current_user.id_type.present?
                             current_user.id_type
          else
            (last_order.present? ? last_order.tax_number_type : '')
          end,
          tax_number: if current_user.id_number.present?
                        current_user.id_number
          else
            (last_order.present? ? last_order.tax_number : '')
          end,
          tax_name: "#{current_user.firstname} #{current_user.lastname}",
          gross_total: current_user.shopping_cart.gross_total_coupon_amount, #New
          discount_rate: 0,
          discount_total: 0,
          net_total: current_user.shopping_cart.gross_total_coupon_amount, #New
          canceled: false,
          paid: false,
          shipping_phone: if current_user.phone.present?
                            current_user.phone
          else
            (last_order.present? ? last_order.shipping_phone : '')
          end,
          shipping_address: if current_user.address.present?
                              current_user.address
          else
            (last_order.present? ? last_order.shipping_address : '')
          end,
          shipping_neighborhood: last_order.present? ? last_order.shipping_neighborhood : '',
          shipping_city: last_order.present? ? last_order.shipping_city : '',

          use_different_billing_address: false,
          payment_method: PaymentMethod.where(active: true).first
        )

      else
        @order = Order.new(
          user: current_user,
          status: :open,
          tax_number_type: if current_user.id_type.present?
                             current_user.id_type
          else
            (last_order.present? ? last_order.tax_number_type : '')
          end,
          tax_number: if current_user.id_number.present?
                        current_user.id_number
          else
            (last_order.present? ? last_order.tax_number : '')
          end,
          tax_name: "#{current_user.firstname} #{current_user.lastname}",
          gross_total: current_user.shopping_cart.gross_total_amount,
          discount_rate: current_user.shopping_cart.discount_rate,
          discount_total: current_user.shopping_cart.discount_total,
          net_total: current_user.shopping_cart.net_total_amount,
          canceled: false,
          paid: false,
          shipping_phone: if current_user.phone.present?
                            current_user.phone
          else
            (last_order.present? ? last_order.shipping_phone : '')
          end,
          shipping_address: if current_user.address.present?
                              current_user.address
          else
            (last_order.present? ? last_order.shipping_address : '')
          end,
          shipping_neighborhood: last_order.present? ? last_order.shipping_neighborhood : '',
          shipping_city: last_order.present? ? last_order.shipping_city : '',

          use_different_billing_address: false,
          payment_method: PaymentMethod.where(active: true).first
        )
      end

      @allItems = []

      current_user.shopping_cart.cart_items.each do |ci|
        productInformation = InternalProduct.find(ci.internal_product_id)

        if productInformation.present?
          current_date_string = Time.now.strftime('%Y%m%d')
          product_discount = ProductDiscount.where(internal_product: ci.internal_product_id)
            .where([' min_quantity <= ? AND max_quantity >= ?',ci.quantity, ci.quantity])
            .where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string]).first

          information = {
            item_id: productInformation.id,
            item_name: productInformation.full_name('es'),
            discount: product_discount.present? ? product_discount.discount_rate : 0,
            item_brand: 'Cavallaro',
            item_category: productInformation.category.name,
            item_variant: productInformation.variety.name,
            price: productInformation.price,
            currency: 'PYG',
            quantity: ci.quantity
          }

          @allItems << information
        end
      end


    else
      redirect_to new_user_session_path, notice: 'Por favor inicia sesión para poder continuar con tu compra.'
    end
  end

  def create
    if params[:order][:tax_number].empty? || params[:order][:tax_name].empty?
      redirect_to order_new_path, alert: "Por favor completa los campos obligatorios."
      return
    end

    #params[:order][:shipping_phone] = params[:order][:shipping_phone].tr(" ()-*", "")
    params[:order][:shipping_phone] = params[:order][:shipping_phone].gsub!(/[^0-9A-Za-z]/, '')

    last_order = Order.where(user: current_user).last

    if !last_order.present?
      current_user.id_number = params[:order][:tax_number]
    else
      if last_order.tax_number != params[:order][:tax_number]
        current_user.id_number = params[:order][:tax_number]
      else
        current_user.id_number = last_order.tax_number
      end
    end

    current_user.save!

    # Check if payment_method is Bancard
    case params[:order][:payment_method_id]
    when '4'
      params[:order][:delivery_payment_method] = 'tarjeta_catastro'
    when '1'
      params[:order][:delivery_payment_method] = 'tarjeta_ocasional'
    when '3'
      params[:order][:delivery_payment_method] = 'zimple'
    end

    @order = Order.new(order_params)

    if @order.delivery_method.internal_name == 'delivery' && (@order.longitude.blank? || @order.latitude.blank?)
      redirect_to order_new_path, alert: 'Debe seleccionar una ubicación en el mapa si la forma de entrega es delivery.'
      return
    end

    if @order.delivery_method.internal_name == 'delivery' && @order.payment_method.internal_name = 'bancard_token' && (@order.longitude.blank? || @order.latitude.blank?)
      redirect_to order_new_path, alert: 'Debe seleccionar una ubicación en el mapa si la forma de entrega es delivery.'
      return
    end

    if @order.payment_method.internal_name == 'zimple' && @order.shipping_phone.blank? #TODO: Chequear esto.
      redirect_to order_new_path, alert: 'Para utilizar Pago Zimple debe ingresar un número de celular válido.'
      return
    end

    #Nuevo chequeo del cupon
    if @order.coupon_code.present?
      token = ENV['ERP_SERVICE_TOKEN']
      url = "#{ENV['ERP_SERVICE_CUPON_URL']}/search"

      service_response = Faraday.get(url, {token:token, keyword: @order.coupon_code})
      response_data = JSON.parse(service_response.body)

      if response_data.empty?
        redirect_to shopping_cart_show_path, alert: "El cupón ingresado no existe."
      elsif !response_data.empty? && response_data[0]["activo"] == false
        redirect_to shopping_cart_show_path, alert: "El cupón ingresado ya está vencido o fue utilizado."
      else
        @order.discount_rate = response_data[0]["descuento"].to_f
        @order.coupon_discount = response_data[0]["descuento"]
      end
    end
    # END del chequeo


    @order.user = current_user
    @order.save #Save all


    current_user.latitude = @order.latitude if @order.latitude.present?
    current_user.longitude = @order.longitude if @order.longitude.present?
    current_user.save

    @order.set_branch_by_distance if @order.delivery_method.internal_name == 'delivery'

    if @order.use_different_billing_address
      @order.update(
        billing_address: @order.shipping_address, billing_neighborhood: @order.shipping_neighborhood,
        billing_city: @order.shipping_city, billing_department: @order.shipping_department,
        billing_phone: @order.shipping_phone, billing_observation: @order.shipping_observation
      )
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_status_path(id: @order.id) }
      else
        format.html { render :new }
      end
    end
  end

  def status
    #GA 4 add payment info"
    if user_signed_in?

      @allItems = []

      current_user.shopping_cart.cart_items.each do |ci|
        productInformation = InternalProduct.find(ci.internal_product_id)

        if productInformation.present?
          current_date_string = Time.now.strftime('%Y%m%d')
          product_discount = ProductDiscount.where(internal_product: ci.internal_product_id)
            .where([' min_quantity <= ? AND max_quantity >= ?',ci.quantity, ci.quantity])
            .where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string]).first

          information = {
            item_id: productInformation.id,
            item_name: productInformation.full_name('es'),
            discount: product_discount.present? ? product_discount.discount_rate : 0,
            item_brand: 'Cavallaro',
            item_category: productInformation.category.name,
            item_variant: productInformation.variety.name,
            price: productInformation.price,
            currency: 'PYG',
            quantity: ci.quantity
          }

          @allItems << information
        end
      end

      if @order.coupon_discount > 0

        #Discount per coupon code
        @discount = (@order.gross_total * @order.coupon_discount) / 100
        total_discount = (@order.gross_total - @discount).round

        #Para chequear
        @order.discount_total = @discount.round
        @order.net_total = total_discount.round
        @order.save
      else
        @discount = @order.discount_total
      end
    else
      redirect_to new_user_session_path, notice: 'Inicia sesion para ingresar a esta sección.'
    end
  end

  def payment; end

  def confirm
    if @order.coupon_discount > 0
      current_user.shopping_cart
        .cart_items
        .each do |item|

          @get_product = InternalProduct.find(item.internal_product_id)
          price = @get_product.price
          gross_total = price * item.quantity
          net_total = gross_total

          @order.order_detail.create(
            internal_product_id: item.internal_product_id,
            quantity: item.quantity,
            unit_price: price,
            gross_total: gross_total,
            discount_rate: 0,
            discount_amount: 0,
            net_total: net_total
          )
        end

    else
      current_user.shopping_cart
        .cart_items
        .each do |item|

          @order.order_detail.create(
            internal_product_id: item.internal_product_id,
            quantity: item.quantity,
            unit_price: item.unit_price,
            gross_total: item.gross_total,
            discount_type: item.discount_type,
            discount_rate: item.discount_type == "escala" ? @order.discount_rate : item.discount_rate, #item.is_discount_import ? 0 : item.discount_rate,
            discount_amount: item.discount_type == "escala" ? ((item.gross_total * @order.discount_rate) / 100).round : item.discount_amount, #item.is_discount_import ? 0 : item.discount_amount,
            net_total: item.discount_type == "escala" ? item.gross_total - ((item.gross_total * @order.discount_rate) / 100).round : item.net_total
          )
        end

        net_total = 0
        discount_total = 0

        @order.order_detail.each do |od|
          net_total += od.net_total
          discount_total += od.discount_amount
        end

        Rails.logger.debug(net_total)
        Rails.logger.debug(discount_total)

        @order.net_total = net_total
        @order.discount_total = discount_total

        @order.save
    end

    if @order.payment_method.internal_name == 'contra_entrega'

      #@first_order = Order.where(user: current_user).where(status: 1).count

      current_user.shopping_cart.clear
      @order.status = :closed
      @order.erp_status = :pending
      @order.save

      #cancelar cupon
      if @order.coupon_code.present?
        #Testing
        name = current_user.firstname
        url = ENV['ERP_SERVICE_CUPON_URL']
        token = ENV['ERP_SERVICE_TOKEN']
        qr_link = current_user.qr_link
        id_number = current_user.id_number

        service_response = Faraday.put(url, "token=#{token}&cupon=#{@order.coupon_code}&razonsocial=#{name}&docnro=#{id_number}")
        response_data = JSON.parse(service_response.body)

        Rails.logger.debug("RESPUESTA DE CAV CANCELACION: #{response_data}")

        if response_data["activo"] == false
          @order.coupon_used = true
          @order.save

          user_order = User.where(id: current_user.id).first

          if user_order.present?
            user_order.coupon_used = true
            user_order.save!
          end
        end
      end

      # For gtag "purchase".
      @allItems = []

      @order.order_detail.each do |od|
        productInformation = InternalProduct.find(od.internal_product_id)

        if productInformation.present?
          current_date_string = Time.now.strftime('%Y%m%d')

          product_discount = ProductDiscount.where(internal_product: od.internal_product_id)
            .where([' min_quantity <= ? AND max_quantity >= ?',od.quantity, od.quantity])
            .where([' begin_date <= ? AND end_date >= ?', current_date_string, current_date_string]).first

          information = {
            item_id: productInformation.id,
            item_name: productInformation.full_name('es'),
            coupon: "",
            currency: 'PYG',
            discount: product_discount.present? ? product_discount.discount_rate : 0,
            item_brand: 'Cavallaro',
            item_category: productInformation.category.name,
            item_variant: productInformation.variety.name,
            price: productInformation.price,
            quantity: od.quantity
          }

          @allItems << information
        end
      end

      render :greeting
      return
    end

    case @order.payment_method.internal_name
    when 'bancard_token'
      redirect_to transaction_payment_token_path(order_id: @order.id)
    when 'bancard'
      redirect_to transaction_payment_path(order_id: @order.id)
    when 'zimple'
      redirect_to transaction_payment_zimple_path(order_id: @order.id)
    else
      redirect_to order_new_path, alert: 'No se ha recibido un método de pago para completar el pedido.'
    end
  end

  def greeting; end

  def history
    unless user_signed_in?
      redirect_to new_user_session_path, notice: 'Inicia sesión para ingresar a esta sección.'
      return
    end

    @orders = current_user.orders.where(status: 1).order(created_at: :desc)
    redirect_to edit_user_registration_path, notice: 'No se encuentran pedidos anteriores en tu cuenta.' if @orders.nil?
  end

  def history_detail
    unless user_signed_in?
      redirect_to new_user_session_path, notice: 'Inicia sesión para ingresar a esta sección.'
      return
    end

    if current_user.id != @order.user_id
      redirect_to order_history_path, notice: 'El pedido solicitado no se encuentra en tu cuenta.'
    end
  end

  def repeat_order
    unless user_signed_in?
      redirect_to new_user_session_path, notice: 'Inicia sesion para ingresar a esta sección.'
      return
    end

    if current_user.id != @order.user_id
      redirect_to order_history_path, notice: 'El pedido solicitado no se encuentra en tu cuenta.'
      return
    end

    if current_user.shopping_cart.nil?
      redirect_to order_history_path, notice: 'No se encuentra carrito de compras para el usuario actual.'
      return
    end

    cart = current_user.shopping_cart

    @order.order_detail.each do |item|
      cart.add_item(item.internal_product, item.quantity)
    end

    redirect_to shopping_cart_show_path, notice: 'Hemos agregado todos los productos de tu pedido al carrito.'
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

        if @order.present?
          @order.gross_total = current_user.shopping_cart.gross_total_amount
          @order.discount_rate = current_user.shopping_cart.discount_rate
          @order.discount_total = current_user.shopping_cart.discount_total
          @order.net_total = current_user.shopping_cart.net_total_amount
          @order.save
        end
      end

      if changed
        changed = false
        return redirect_to shopping_cart_show_path, notice: "Hubieron variaciones de precios en los productos que seleccionaste para tu compra."
      end
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def check_order
    if @order.status_canceled? || @order.status_closed?
      redirect_to shopping_cart_show_path,
      alert: "Estas intentando utilizar una orden que ya fue cancelada o realizada previamente, completa de nuevo los procesos de compra."
      return
    end
  end

  def order_params
    params.require(:order).permit(
      :tax_number_type, :tax_number, :tax_name, :paid, :payment_transaction_id,
      :payment_date, :shipping_phone, :shipping_address, :shipping_observation, :shipping_department,
      :shipping_city, :shipping_neighborhood, :billing_address, :billing_phone, :billing_observation,
      :billing_department, :billing_city, :billing_neighborhood, :created_at, :updated_at,
      :delivery_method_id, :payment_method_id, :gross_total, :discount_total, :branch_id,
      :use_different_billing_address, :delivery_payment_method, :gross_total, :discount_rate, :status,
      :discount_total, :net_total, :latitude, :longitude, :bank_transfer_reference, :coupon_code, :coupon_discount, :coupon_used)
  end
end
