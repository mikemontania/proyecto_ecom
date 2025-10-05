module OrderHelper
  def check_coupon(coupon)
    data = coupon
    url = "#{ENV['ERP_SERVICE_CUPON_URL']}/search"
    token = ENV['ERP_SERVICE_TOKEN']

    Rails.logger.debug("HOLA: #{coupon}")
    service_response = Faraday.get(url, {token:token, keyword: data.coupon_code})
    response_data = JSON.parse(service_response.body)

    if response_data.empty?
      redirect_to shopping_cart_show_path, alert: "El cupon ingresado no existe."
    elsif !response_data.empty? && response_data[0]["activo"] == false
      redirect_to shopping_cart_show_path, alert: "El cupon ingresado ya está vencido o fue utilizado"
    else
      return response_data[0]
    end
  end
end
