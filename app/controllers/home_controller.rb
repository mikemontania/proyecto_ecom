class HomeController < ApplicationController

  # temporal
  def promo1; end
  def promo2; end

  def create
    params_validations

    #Check double
    if Newsletter.find_by(email: params[:newsletter][:email]).present?
      redirect_to root_path, alert: "Tu correo ya esta registrado a nuestro Newsletter."
      return
    end

    newsletter = Newsletter.new(newsletter_params)

    #verify captcha
    if verify_recaptcha(model: newsletter) && newsletter.save
      NewsletterMailer.with(newsletter: newsletter).welcome_email.deliver
      redirect_to root_path, notice: "Gracias por subscribirte a nuestro Newsletter"
    else
      redirect_to root_path, alert: "No se pudo enviar, el Captcha no es correcto."
    end
  end

  def destroy
    validate_subscriber(params[:email].to_s)
  end

  def cookie
    cookies[:cookie_accepted] = true
    respond_to do |format|
      format.js { render laoyout: false, content_type: 'text/javascript' }
    end
  end

  def index
    @category_list = Category
      .joins(:products)
      .joins(:internal_products)
      .includes(products: :varieties)
      .eager_load(:products)
      .eager_load(:internal_products)
      .eager_load(products: :varieties)
      .where(categories: { active: true })
      .where(products: { active: true })
      .where(internal_products: { active: true })
      .order(:slug)
      .order('products.order asc')

    @brand_list = Brand.where(active: true)
    @slider_images = Slider.where(active: true).limit(3).order(order: :asc)

    respond_to do |format|
      format.html
      format.html.phone
    end
  end

  # custom
  def history; end

  def contacto; end

  def contact
    #success = verify_recaptcha(action: 'contact', minimum_score: 0.5, secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'])
    #score = recaptcha_reply['score']
    #Rails.logger.warn("User #{params[:name]} was denied because of a recaptcha score of #{score}")
    #checkbox_success = verify_recaptcha unless success
    checkbox_success = verify_recaptcha

    if checkbox_success
      email = params[:email]
      name = params[:name]
      subject = params[:subject]
      message = params[:message]

      ContactMailer.with(email: email, name: name, subject: subject, message: message).contact_email.deliver
      ContactUserMailer.with(email: email, name: name, subject: subject, message: message).contact_email.deliver

      redirect_to contacto_path, notice: 'Gracias por tu mensaje, te responderemos en la brevedad posible.'
    else
    #  if !success
    #    @show_checkbox_recaptcha = true
    #  end
      redirect_to contacto_path, alert: 'Debes completar el captcha correctamente.'
    end
  end

  def set_language
    selected_language = params[:lang]
    cookies.delete :lang
    cookies.permanent[:lang] = selected_language

    message = case selected_language
              when 'en'
                'Language updated!'
              when 'pt'
                'Idioma atualizada!'
              else
                'Idioma actualizado!'
              end

    redirect_to root_path, notice: message
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
      newsletter = Newsletter.new(newsletter_params)
      if verify_recaptcha(model: newsletter) && newsletter.save
        NewsletterMailer.with(newsletter: newsletter).welcome_email.deliver
        redirect_to root_path, notice: "Gracias por subscribirte a nuestro Newsletter"
      else
        redirect_to root_path, alert: "No se pudo enviar, el Captcha no es correcto."
      end

      #Send Email to the User.
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
