class SendOrdersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    settings = Setting.all.first

    return unless settings

    if settings.send_orders_to_service
      orders_to_send = Order.where(erp_status: :pending).where(status: :closed)

      Rails.logger.debug("Order to send: #{orders_to_send.inspect}")

      unless orders_to_send.count.zero?
        Rails.logger.info "hay (#{orders_to_send.count}) pedidos que procesar"

        orders_array = []

        orders_to_send.each do |order|
          orders_array << order.to_json_for_service unless order.order_detail.count.zero?
        end

        url = ENV['ERP_SERVICE_URL'].to_s
        token = ENV['ERP_SERVICE_TOKEN'].to_s

        con = Faraday.new(url: url)

        service_response = con.post do |req|
          req.headers['Content-type'] = 'application/json'
          req.params['token'] = token
          req.body = orders_array.to_json
        end

        response = JSON.parse(service_response.body)

        Rails.logger.debug("Respuesta ERP Envio: #{response}")

        response.each do |r|
          id = r['id']
          estado = r['estado']
          obs = r['obs']

          order_result = Order.find(id)
          next unless order_result

          if obs.to_s === "null el codigo de orden ya existe"
            order_result.erp_status = :sent
          else
            order_result.erp_status = estado == 'ERROR' ? :pending : :sent #Analizar esto, ver si se puede agregar códigos de errores.
          end

          # 1 = error orden ya existe
          # 2 = error el servicio no funciona

          order_result.erp_error = estado #== 'ERROR'
          order_result.erp_message = obs
          order_result.erp_sent_at = Time.now
          order_result.save!

          puts "Order updated (#{order_result.id})"
        end

      end
    else
      Rails.logger.warn 'ENVIO DE PEDIDOS DESHABILITADO EN CONFIGURACION.'
    end
  end
end
