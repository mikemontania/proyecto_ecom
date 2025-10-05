class ContactMailer < ApplicationMailer
  default from: 'Grupo Cavallaro <no-reply@cavallaro.com.py>'

  def contact_email
    to_email = Setting.first.contact_email

    if to_email.blank?
      Rails.logger.warning('No se ha definido una email de contacto en la configuracion.')
    else
      @email = params[:email]
      @subject = params[:subject]
      @message = params[:message]
      @name = params[:name]

      mail(to: to_email, subject: "Nuevo contacto: #{@subject}")
    end
  end
end
