class ApplicationController < ActionController::Base
  before_action :detect_device_format
  before_action :set_variables, :set_shopping_cart
  before_action :delivery_schedule
  before_action :countdown
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_variables
    @pages = Page.where(active: true).order(order: :asc)
    @branches = Branch.where(active: true)

    #if cookies[:lang].blank?
    #  origin_accepted_langs = request.env['HTTP_ACCEPT_LANGUAGE']
    #  supported_lang = AcceptLanguage.intersection(origin_accepted_langs, :es, :en, :pt, two_letter_truncate: true)
    #  multilanguage_enabled = Setting.all.first.multilanguage
    #  supported_lang = :es if supported_lang.nil? || !multilanguage_enabled
    #  cookies[:lang] = supported_lang.to_s
    #end

    #@lang = cookies[:lang]
  end


  def delivery_schedule
    get_delivery = DeliverySchedule.find(1)

    today = Date.today
    todays_date = today.strftime('%d%m%Y').to_i

    # Put everything into an array
    delivery_holydays = get_delivery.holydays.split(',').map { |d| d.delete('/').to_i }

    if today.sunday?
      today += 1
      todays_date = today.strftime('%d%m%Y').to_i

      delivery_holydays.each do |hd|
        if hd.to_i == todays_date
          today += 1
          todays_date = today.strftime('%d%m%Y').to_i
        end
      end
    else

      today += 1
      todays_date = today.strftime('%d%m%Y').to_i

      delivery_holydays.each do |hd|
        if hd.to_i == todays_date
          today += 1
          todays_date = today.strftime('%d%m%Y').to_i
        end
      end
    end

    @delivery_info = get_delivery

    @day_name = if today.saturday?
                  0
                else
                  1
                end

    @delivery_date = l(today, format: :delivery_date)
  end

  def set_shopping_cart
    session_cart_uuid = session[:shopping_cart]
    @shopping_cart ||= ShoppingCart.shopping_cart_factory(
      user_signed_in? ? current_user : nil,
      session_cart_uuid,
      'application_controller'
    )

    session[:shopping_cart] = @shopping_cart.present? ? @shopping_cart.session_uuid : nil

    return @shopping_cart if @shopping_cart.nil?

    if @shopping_cart.user.present? && session_cart_uuid
      @shopping_cart.merge_cart(session_cart_uuid)
      session[:shopping_cart] = nil
    end
  end

  def configure_permitted_parameters
    attributes = %i[
    firstname
    lastname
    id_type
    id_number
    address
    phone
    subscribed
    latitude
    longitude
    qr_link
    new_user
    ]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)

    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def countdown
    countdown = Countdown.where(id: 1).first

    if countdown.present?
      date_now = Date.today.strftime("%Y%m%d").to_i
      countdown_start_date = countdown.start_date.strftime("%Y%m%d").to_i
      countdown_end_date = countdown.end_date.strftime("%Y%m%d").to_i

      if countdown_start_date <= date_now && countdown_end_date >= date_now
        @time = countdown.end_date.strftime("%Y/%m/%d %H:%m:%S")
      end
    end
  end

  def detect_device_format
    case request.user_agent
    when /iPad/i
      request.variant = :tablet
    when /iPhone/i
      request.variant = :phone
    when /Android/i && /mobile/i
      request.variant = :phone
    when /Android/i
      request.variant = :tablet
    when /Windows Phone/i
      request.variant = :phone
    end
  end

end
