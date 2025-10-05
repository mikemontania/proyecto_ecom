class WelcomeMailer < ApplicationMailer
  default from: 'Grupo Cavallaro <no-reply@cavallaro.com.py>'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Gracias por registrarte en Cavallaro!')
  end
end
