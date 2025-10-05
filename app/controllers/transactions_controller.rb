require 'digest/md5'
class TransactionsController < ApplicationController
  before_action :authenticate_user!, except: [:transaction_confirm]
  before_action :set_cache_buster, only: %i[
  transaction_payment
  transaction_payment_token_new_card
  transaction_payment_token_charge
  transaction_cancel]

  before_action :check_prices_update, only: %i[
  transaction_payment
  transaction_payment_token
  transaction_payment_token_new_card]

  before_action :set_order, only: %i[
    transaction_payment_token
    transaction_payment
    transaction_payment_token_new_card
    transaction_payment_token_charge
    transaction_payment_zimple
    check_order
  ]

  before_action :check_order, only: %i[
    transaction_payment_token
    transaction_payment
    transaction_payment_token_new_card
    transaction_payment_token_charge
    transaction_payment_zimple
  ]

  protect_from_forgery except: [:transaction_confirm]

  def transaction_payment_token

    transaction_date = Date.current
    transaction_time = Time.current

    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/users/#{@order.user_id}/cards"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    token = Digest::MD5.hexdigest(private_key + current_user.id.to_s + "request_user_cards")

    if @order.payment_method.internal_name == 'bancard_token'

      data = {
        'public_key' => public_key,
        'operation' => {
          'token' => token
        }
      }

      card_response = Net::HTTP.post URI(api_url), data.to_json, 'Content-type' => 'application/json'

      response_data = JSON.parse(card_response.body)
      if response_data['status'] == 'success'
        @cards = response_data["cards"]
      end

      if params[:status].present?
        if params[:status] != 'add_new_card_success'
          flash.now[:warning] = params[:description]
        end
      end

    end
  end

  def transaction_payment_token_new_card

    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']
    description = "Compras pruebas cavallaro"

    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/cards/new"

    fecha_transaccion = Date.today.strftime("%Y%m%d") #8
    hora_transaccion = Time.zone.now.strftime("%H%M%S") #6
    card_id = fecha_transaccion.to_s + hora_transaccion.to_s
    user_id = current_user.id

    token = Digest::MD5.hexdigest(private_key + card_id.to_s + user_id.to_s + "request_new_card")

    data = {
      "public_key" => public_key,
      "operation" => {
        "token" => token,
        "card_id" => card_id.to_i,
        "user_id" => user_id.to_i,
        "user_cell_phone" => @order.shipping_phone,
        "user_mail" => current_user.email,
        "return_url" => "#{ENV['RETURN_CANCEL_BANCARD']}/checkout/pago-tarjetas/#{@order.id}"
      }
    }

    new_card_response = Net::HTTP.post URI(api_url), data.to_json, "Content-type" => "application/json"
    responseData = JSON.parse(new_card_response.body)

    if responseData["status"] == "success"
      @process_id = responseData["process_id"]
    else
      flash.now[:warning] = responseData
      Rails.logger.debug("Mensaje de respuesta new card: #{responseData}")
    end

    respond_to do |format|
      format.html
    end
  end

  def transaction_payment_token_charge

    alias_token = params[:a_token]

    transaction_date = Date.current
    transaction_time = Time.current

    @transaction = BancardTransaction.create!(
      order: @order,
      transaction_status: :pending,
      transaction_date: transaction_date,
      transaction_time: transaction_time,
      total_amount: @order.net_total,
      currency: 'PYG',
      description: 'Compras CAVALLARO.COM.PY'
    )

    @transaction.set_shop_process_id

    #Presave
    @transaction.save!

    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/charge"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    token = Digest::MD5.hexdigest(private_key + @transaction.shop_process_id.to_s + "charge" + @transaction.formatted_amount + @transaction.currency + alias_token.to_s)

    if @order.payment_method.internal_name = "bancard_token"

      data = {
        "public_key" => public_key,
        "operation" => {
          "token" => token,
          "shop_process_id" => @transaction.shop_process_id,
          "amount" => @transaction.formatted_amount,
          "number_of_payments" => 1,
          "currency" => @transaction.currency,
          "additional_data" => "",
          "description" => @transaction.description,
          "alias_token" => alias_token
        }
      }

      charge_response = Net::HTTP.post URI(api_url), data.to_json, "Content-type" => "application/json"

      response_data = JSON.parse(charge_response.body)

      if response_data['status'] == 'success'

        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!

        redirect_to transaction_status_path(transaction_id: @transaction.id, process_id: @transaction.shop_process_id)

      else

        @transaction.transaction_status = :error
        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!

        redirect_to root_path, alert: "Hubo un error al intentar realizar la compra, por favor vuelve a intentarlo"
      end
    else
      redirect_to shopping_cart_show_path, alert: "Hubo un error al intentar realizar la compra, por favor vuelve a intentarlo"
    end
  end

  def transaction_payment_token_delete_card

    @card_token = params[:ct]
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/users/#{current_user.id}/cards"
    generated = private_key + "delete_card" + current_user.id.to_s + @card_token

    token = Digest::MD5.hexdigest(private_key + "delete_card" + current_user.id.to_s + @card_token.to_s)

    data = {
      "public_key" => public_key,
      "operation" => {
        "token" => token,
        "alias_token" => @card_token
      }
    }

    conn = Faraday.new

    responseData = conn.delete(api_url) do |req|
      req.headers["Content-type"] = "application/json"
      req.body = data.to_json
    end

    if responseData["status"] == "success"
      flash[:success] = "Tu tarjeta ha sido eliminada de tu lista de tarjetas"
      redirect_back(fallback_location: root_path)
    else
      flash[:warning] = "Hubo un error al intentar borrar su tarjeta, por favor, pongase en contacto con nosotros"
      redirect_back(fallback_location: root_path)
    end
  end


  def transaction_payment

    transaction_date = Date.current
    transaction_time = Time.current

    @transaction = BancardTransaction.create!(
      order: @order,
      transaction_status: :pending,
      transaction_date: transaction_date,
      transaction_time: transaction_time,
      total_amount: @order.net_total,
      currency: 'PYG',
      description: 'Compras CAVALLARO.COM.PY'
    )

    @transaction.set_shop_process_id

    # Bancard transaction data
    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/single_buy"
    return_url = "#{ENV['RETURN_STATUS_BANCARD']}/checkout/estado/#{@transaction.id}/#{@transaction.shop_process_id}"
    cancel_url = "#{ENV['RETURN_CANCEL_BANCARD']}/checkout/cancelar/#{@transaction.id}/#{@transaction.shop_process_id}"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    token = Digest::MD5.hexdigest(
      private_key + @transaction.shop_process_id.to_s + @transaction.formatted_amount + @transaction.currency
    )

    @transaction.token = token
    @transaction.api_url = api_url
    @transaction.return_url = return_url
    @transaction.cancel_url = cancel_url

    if @order.payment_method.internal_name == 'bancard'

      data = {
        'public_key' => public_key,
        'operation' => {
          'token' => @transaction.token,
          'shop_process_id' => @transaction.shop_process_id,
          'currency' => @transaction.currency,
          'amount' => @transaction.formatted_amount,
          'additional_data' => '',
          'description' => @transaction.description,
          'return_url' => @transaction.return_url,
          'cancel_url' => @transaction.cancel_url
        }
      }

      response = Net::HTTP.post URI(@transaction.api_url), data.to_json, 'Content-type' => 'application/json'

      response_data = JSON.parse(response.body)
      if response_data['status'] == 'success'

        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!

      else

        @transaction.transaction_status = :error
        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!

        redirect_to root_path, alert: 'Hubo un error al intentar realizar la compra, por favor vuelve a intentarlo'

      end
    else
      redirect_to shopping_cart_show_path, alert: 'Hubo un error al intentar realizar la compra, por favor vuelve a intentarlo'
    end
  end

  def transaction_payment_zimple

    transaction_date = Date.current
    transaction_time = Time.current

    @transaction = BancardTransaction.create!(
      order: @order,
      transaction_status: :pending,
      transaction_date: transaction_date,
      transaction_time: transaction_time,
      total_amount: @order.net_total,
      currency: 'PYG',
      description: 'Compras CAVALLARO.COM.PY'
    )

    @transaction.set_shop_process_id

    # Bancard transaction data
    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/single_buy"
    return_url = "#{ENV['RETURN_STATUS_BANCARD']}/checkout/estado/#{@transaction.id}/#{@transaction.shop_process_id}"
    cancel_url = "#{ENV['RETURN_CANCEL_BANCARD']}/checkout/cancelar/#{@transaction.id}/#{@transaction.shop_process_id}"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    token = Digest::MD5.hexdigest(
      private_key + @transaction.shop_process_id.to_s + @transaction.formatted_amount + @transaction.currency
    )
    @transaction.token = token
    @transaction.api_url = api_url
    @transaction.return_url = return_url
    @transaction.cancel_url = cancel_url

    if @order.payment_method.internal_name == 'zimple'

      data = {
        'public_key' => public_key,
        'operation' => {
          'token' => @transaction.token,
          'shop_process_id' => @transaction.shop_process_id,
          'currency' => @transaction.currency,
          'amount' => @transaction.formatted_amount,
          'additional_data' => @transaction.order.shipping_phone,
          'description' => @transaction.description,
          'return_url' => @transaction.return_url,
          'cancel_url' => @transaction.cancel_url,
          'zimple' => 'S'
        }
      }

      response = Net::HTTP.post URI(@transaction.api_url), data.to_json, 'Content-type' => 'application/json'

      response_data = JSON.parse(response.body)
      if response_data['status'] == 'success'

        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!
      else
        @transaction.transaction_status = :error
        @transaction.response = response_data['status']
        @transaction.process_id = response_data['process_id']
        @transaction.response_details = response_data
        @transaction.save!

        redirect_to root_path, alert: "Hubo un error al intentar realizar el pago Zimple: #{response_data['messages'].first['dsc']}."

      end
    else
      redirect_to shopping_cart_show_path, alert: 'Hubo un error al intentar realizar la compra, por favor vuelve a intentarlo'
    end
  end

  def transaction_confirm
    if !params[:operation].present?
    else

      operation = params[:operation]

      unless BancardTransaction.valid_token?(operation)
        Rails.logger.debug("CONFIRM: Error, Token mismatch.")
      end

      transaction = BancardTransaction.where(shop_process_id: operation[:shop_process_id]).first

      if transaction
        transaction.process_response(operation)

      else
        Rails.logger.debug("CONFIRM: Error, no se encontró la transacción.")
      end
    end
    render json: { status: 200 }
  end

  def transaction_status
    transaction_id = params[:transaction_id]
    shop_process_id = params[:process_id]
    @transaction = BancardTransaction.where(shop_process_id: shop_process_id).where(id: transaction_id).first

    if @transaction
      if @transaction.response_code == '00' && @transaction.transaction_status != 'success'
        @transaction.transaction_status = :success

      end

      #@first_order = Order.where(user: current_user).where(status: 1).count

      if @transaction.transaction_status == 'success'

        order = @transaction.order
        order.status = :closed
        order.paid = true
        order.erp_status = :pending
        order.payment_date = @transaction.transaction_date
        order.payment_transaction_id = @transaction.ticket_number

        order.save

        @transaction.transaction_status = :confirmed
        current_user.shopping_cart.clear

        #Mandar para cancelar cupon
        name = current_user.firstname
        url = ENV['ERP_SERVICE_CUPON_URL']
        token = ENV['ERP_SERVICE_TOKEN']
        qr_link = current_user.qr_link
        id_number = current_user.id_number

        service_response = Faraday.put(url, "token=#{token}&cupon=#{order.coupon_code}&razonsocial=#{name}&docnro=#{id_number}")

        response_data = JSON.parse(service_response.body)

        if response_data["activo"] == false
          order.coupon_used = true
          order.save

          user_order = User.where(id: current_user.id).first

          if user_order.present?
            user_order.coupon_used = true
            user_order.save!
          end
        end

      else

        order = @transaction.order
        order.status = :canceled
        order.paid = false
        order.erp_status = :uncomplete
        order.payment_date = @transaction.transaction_date
        order.payment_transaction_id = 0

        order.save

        @transaction.transaction_status = :error
        order.payment_date = @transaction.transaction_date
        alert_message = "No se pudo confirmar la transacción. #{@transaction.response_description.present? ? @transaction.response_description : '' } #{ @transaction.extended_description.present? ? '- '+@transaction.extended_description.downcase : '' }"
        redirect_to shopping_cart_show_path, alert: alert_message, transaction: @transaction

      end

      @transaction.save!

    else
      alert_message = 'Ha ocurrido un error en el proceso, por favor vuelta a intentarlo. '
      redirect_to root_path, alert: alert_message
    end
  end

  def transaction_cancel
    transaction_id = params[:transaction_id]
    shop_process_id = params[:process_id]

    @transaction = BancardTransaction.where(shop_process_id: shop_process_id).where(id: transaction_id).first
    # TODO: Check user in transaction query

    if !@transaction
      alert_message = 'Ha ocurrido un error con su proceso, por favor vuelva a intentarlo.'
      redirect_to root_path, alert: alert_message
    else
      @transaction.transaction_status = :canceled
      @transaction.save!
    end
  end

  def transaction_rollback
    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/single_buy/rollback"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    transaction_id = params[:transaction_id]
    transaction = BancardTransaction.where(id: transaction_id).where(transaction_status: :confirmed).first

    if transaction
      token = Digest::MD5.hexdigest(private_key + transaction.shop_process_id + 'rollback' + '0.00')
      shop_process_id = transaction.shop_process_id.to_s

      data = {
        'public_key' => public_key,
        'operation' => {
          'token' => token,
          'shop_process_id' => shop_process_id
        }
      }

      response = Net::HTTP.post URI(api_url), data.to_json, 'Content-type' => 'application/json'
      response_data = JSON.parse(response.body)
      render json: "Respuesta del Rollback Bancard: #{response_data}"

      if response_data['status'] == 'success'
        transaction.transaction_status = :rollback
        transaction.save!
      end
    else
      Rails.logger.debug('La transaccion seleccionada no es una transaccion aprobada por Bancard.')
    end
  end

  def transaction_origin_confirmation
    api_url = "#{ENV['BANCARD_URL']}/vpos/api/0.3/single_buy/confirmations"
    public_key = ENV['BANCARD_PUBLIC_KEY']
    private_key = ENV['BANCARD_PRIVATE_KEY']

    transaction_id = params[:transaction_id]
    transaction = BancardTransaction.where(id: transaction_id).first

    if transaction
      token = Digest::MD5.hexdigest(private_key + transaction.shop_process_id.to_s + 'get_confirmation')
      shop_process_id = transaction.shop_process_id

      data = {
        'public_key' => public_key,
        'operation' => {
          'token' => token,
          'shop_process_id' => shop_process_id
        }
      }

      response = Net::HTTP.post URI(api_url), data.to_json, 'Content-type' => 'application/json'
      response_data = JSON.parse(response.body)
      render json: "Respuesta del Confirmation Bancard: #{response_data}"

    else
      Rails.logger.debug('La transaccion seleccionada no es una transaccion reconocida por Bancard.')
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
    if params[:order_id].present?
      order_id = params[:order_id]
    elsif params[:order].present?
      order_id = params[:order]
    else
      order_id = '';
    end

    @order = Order.find(order_id)
  end

  def check_order
    if @order.status_canceled? || @order.status_closed?
      redirect_to shopping_cart_show_path,
      alert: "Estas intentando utilizar una orden que ya fue cancelada o realizada previamente, completa de nuevo los procesos de compra."
      return
    end
  end

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
