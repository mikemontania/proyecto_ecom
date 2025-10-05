class ContactUserMailer < ApplicationMailer
  default from: 'Grupo Cavallaro <no-reply@cavallaro.com.py>'

  def contact_email
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]
    @name = params[:name]

    mail(to: @email, subject: "Tu mensaje de contacto: #{@subject}")
  end
end

