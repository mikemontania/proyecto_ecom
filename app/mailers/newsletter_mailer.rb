class NewsletterMailer < ApplicationMailer
  default from: 'Grupo Cavallaro <no-reply@cavallaro.com.py>'

  def welcome_email
    @newsletter = params[:newsletter]

    #Replace email from . to -
    email = @newsletter.email
    @replacedEmail = email.gsub(".") do |letter|
      "-"
    end

    mail(to: @newsletter.email, subject: 'Gracias por subscribirte al Newsletter de Cavallaro!')
  end
end

