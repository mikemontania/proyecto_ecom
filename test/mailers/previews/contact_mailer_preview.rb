# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_email
    email = 'desarrollo@creadores.com.py'
    name = 'Usuario de prueba'
    subject = 'Prueba de correo cavallaro'
    message = 'Este es un mensaje de prueba desde cavallaro.com.py lorem Este es un mensaje de prueba desde cavallaro.com.py '

    ContactMailer.with(email: email, name: name, subject: subject, message: message).contact_email
  end
end
