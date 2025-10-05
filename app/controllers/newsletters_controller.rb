class NewslettersController < ApplicationController

  def create
    success = verify_recaptcha(action: 'newsletter', minimum_score: 0.5, secret_key: ENV['RECAPTCHA_SECRET_KEY'])
    checkbox_success = verify_recaptcha unless success
    if success || checkbox_success
      # Perform action
    else
      if !success
        @show_checkbox_recaptcha = true
      end
      render "index"
    end

    name = params[:newsletter][:name]
    email = params[:newsletter][:email]
    website = params[:newsletter][:website]
    if website != "" || !website.empty?
      return
    end

    params_validations
    create_newsletter(email)
  end

  def destroy
    validate_subscriber(params[:email].to_s)
  end

  private

  def params_validations
    if params.empty?
      redirect_to root_path, alert: "Por favor completa todos los campos solicitados para subscribirte."
      return
    end
  end

  def validate_subscriber(email)

    #Replace email from - to .
    replaced_email = email.gsub("-") do |letter|
      "."
    end

    newsletter = Newsletter.where(email: replaced_email).first

    if newsletter.present?
      current_email = newsletter.email
      newsletter.destroy

      redirect_to root_path, notice: "Tu correo #{current_email} ya no esta suscripto a nuestro Newsletter."
      return
    else

      redirect_to root_path, alert: "El correo solicitado no esta suscripto a nuestro Newsletter."
      return
    end
  end

  def create_newsletter(email)
    if Newsletter.find_by(email: email).present?
      redirect_to root_path, alert: "Tu correo ya esta registrado a nuestro Newsletter."
      return
    else
      newsletter = Newsletter.create(newsletter_params)

      #Send Email to the User.
      #NewsletterMailer.with(newsletter: newsletter).welcome_email.deliver
      render "index"
      #redirect_to root_path, notice: "Gracias por subscribirte a nuestro Newsletter"
      return
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
