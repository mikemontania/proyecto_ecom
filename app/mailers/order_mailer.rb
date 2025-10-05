class OrderMailer < ApplicationMailer
  default from: 'Grupo Cavallaro <no-reply@cavallaro.com.py>'
  def order_email(order)
    @order = order
    mail(to: @order.user.email, subject: 'Hemos recibido tu pedido!')
    @order.mail_sent_at = Time.now
    @order.save
  end
end
