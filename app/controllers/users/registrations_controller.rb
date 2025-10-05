require 'digest/md5'
class Users::RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha
      super do |user|
        if user.new_user == true

          #Envio para creación de Cupon
          name = user.firstname
          url = ENV['ERP_SERVICE_CUPON_URL']
          token = ENV['ERP_SERVICE_TOKEN']
          qr_link = user.qr_link
          id_number = user.id_number

          Rails.logger.debug("nombre: #{name} - QR_LINK #{qr_link} - idnumber #{id_number}")
          data_params = "token=#{token}&docnro=#{id_number}&razonsocial=#{name}&qr=#{qr_link}"
          Rails.logger.debug("Data params: #{data_params}")

          service_response = Faraday.post(url, data_params)
          response_data = JSON.parse(service_response.body)

          Rails.logger.debug(response_data)
        end

        if user.subscribed == true
          check_subscription = Newsletter.where(email: user.email).first

          if check_subscription.nil?
            new_subscription = Newsletter.create(name: user.firstname, email: user.email)
            NewsletterMailer.with(newsletter: new_subscription).welcome_email.deliver
          end
        end

      end
    else
      @user = User.new
      redirect_to new_registration_path(@user), alert: 'Debes completar el captcha correctamente.'
    end
  end

  def edit
    if current_user.from_sm == true && current_user.new_sm == false && current_user.new_user == true
      url = "#{ENV['ERP_SERVICE_CUPON_URL']}/search"
      token = ENV['ERP_SERVICE_TOKEN']

      Rails.logger.debug("USUARIO #{current_user.id_number}")
      id_number = current_user.id_number
      service_response = Faraday.get(url, {token:token, keyword: id_number})
      response_data = JSON.parse(service_response.body)

      if response_data.present?
        @coupons_list = response_data
      end
    end
  end

  protected

  #Update attributes without current password, but let user change their password.
  def update_resource(resource, params)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)

      if resource.from_sm && resource.new_sm && resource.new_user

        #  #Create coupon
        name = resource.firstname
        url = ENV['ERP_SERVICE_CUPON_URL']
        token = ENV['ERP_SERVICE_TOKEN']
        qr_link = resource.qr_link
        id_number = params[:id_number]

        data_params = "token=#{token}&docnro=#{id_number}&razonsocial=#{name}&qr=#{qr_link}"
        service_response = Faraday.post(url, data_params)
        response_data = JSON.parse(service_response.body)

        Rails.logger.debug("Respuesta del cupon: #{response_data}")

        if response_data['activo'].to_s == "true"
          resource.new_sm = false
          resource.coupon_code = response_data['cupon']
        end
      end

      flash[:notice] = "Se ha generado un cupón de descuento, revísalo en tu perfil de usuario.".html_safe
      resource.update_without_password(params)

    else
      super
    end

  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
