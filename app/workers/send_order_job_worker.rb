class SendOrderJobWorker
  include Sidekiq::Worker

  def perform(*args)
    settings = Setting.all.first

    return unless settings

    if settings.send_orders_to_service
      orders_to_send = Order.where(erp_status: :pending).where(status: :closed).where(erp_sent_at: nil)

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

        Rails.logger.debug("Respuesta ERP Envio de Pedido: #{response}")

        response.each do |r|
          id = r['id']
          estado = r['estado']
          obs = r['obs']

          order_result = Order.find(id)
          next unless order_result

          if estado.to_s == "OK"
            order_result.erp_status = :sent
            order_result.erp_message = obs
            order_result.erp_sent_at = Time.now

            #nuevo chequeo con tipo "error"
          else
            order_result.erp_status = :error
            order_result.erp_message = obs
            order_result.erp_sent_at = nil
          end

          #elsif estado.to_s == "ERROR" || obs.to_s == "null el codigo de orden ya existe"
          #  order_result.erp_status = :sent
          #  order_result.erp_message = obs
          #  order_result.erp_sent_at = Time.now

          #elsif estado.to_s == "ERROR" && obs.to_s != "null el codigo de orden ya existe"
          #  order_result.erp_status = :pending
          #  order_result.erp_message = obs
          #  order_result.erp_sent_at = nil
          #end

          order_result.save!

          puts "Order updated (#{order_result.id}) to erp status: #{ order_result.erp_status } - at Time: #{ order_result.erp_sent_at }"
        end

      end
    else
      Rails.logger.warn 'ENVIO DE PEDIDOS DESHABILITADO EN CONFIGURACION.'
    end
  end
end
