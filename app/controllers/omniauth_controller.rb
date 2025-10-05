class OmniauthController < Devise::OmniauthCallbacksController

  def facebook
    promo = request.env['omniauth.params']['promo']
    if promo.present?
      qr_link = "https://www.cavallaro.com.py/promociones/#{promo}"
    else
      qr_link = ""
    end

    @user = User.create_from_provider_data(request.env['omniauth.auth'], qr_link)
    if @user.persisted?
      if @user.new_sm && @user.from_sm && @user.qr_link.present? && @user.coupon_code.nil?
        sign_in @user
        redirect_to edit_user_registration_path, notice: "Iniciaste sesión correctamente. Completa tus datos para obtener tu cupón de descuento."
      else
        sign_in @user
        redirect_to root_path, notice: "Iniciaste sesión correctamente."
      end
    else
      user_taken = User.where(email: @user.email).first
      if user_taken.present?
        provider = case user_taken.provider
                   when 'google_oauth2'
                     'Google'
                   else
                     'Correo Electrónico'
                   end
        redirect_to new_user_session_path, alert: "Hubo un problema con el inicio de sesión de Facebook, esta cuenta ya se ha registrado con #{provider}."
        return
      end

      redirect_to new_user_registration_path, alert: 'Hubo un problema con el inicio de sesión de Facebook. Intentalo de nuevo.'
    end
  end

  def google_oauth2
    promo = request.env['omniauth.params']['promo']
    if promo.present?
      qr_link = "https://www.cavallaro.com.py/promociones/#{promo}"
    else
      qr_link = ""
    end

    @user = User.create_from_provider_data(request.env['omniauth.auth'], qr_link)
    if @user.persisted?
      if @user.new_sm && @user.from_sm && @user.qr_link.present? && @user.coupon_code.nil?
        sign_in @user
        redirect_to edit_user_registration_path, notice: "Iniciaste sesión correctamente. Completa tus datos para obtener tu cupón de descuento."
      else
        sign_in @user
        redirect_to root_path, notice: "Iniciaste sesión correctamente."
      end
    else
      user_taken = User.where(email: @user.email).first
      if user_taken.present?
        provider = case user_taken.provider
                   when 'facebook'
                     'Facebook'
                   else
                     'Correo Electrónico'
                   end
        redirect_to new_user_session_path, alert: "Hubo un problema con el inicio de sesión de Google, esta cuenta ya se ha registrado con #{provider}."
        return
      end
      redirect_to new_user_registration_path, alert: 'Hubo un problema con el inicio de sesión de Google. Intentalo de nuevo.'
    end
  end

  def failure
    flash[:error] = 'Hubo un problema con el inicio de sesión. Intentalo de nuevo.'
    redirect_to new_user_registration_path
  end
end
