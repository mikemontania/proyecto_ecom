# frozen_string_literal: true

class Panel::Admins::RegistrationsController < Devise::RegistrationsController
  layout 'panel/panel_layout'

  skip_before_action :require_no_authentication
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    id = params[:id]
    @admin = Admin.find(id)
  end

  def update
    
    admin_id = params[:panel_admin][:id]
    admin_email = params[:panel_admin][:email]
    admin_password = params[:panel_admin][:password]

    admin = Admin.find(admin_id)

    if admin.present?
      if !admin_password.empty?
        admin.email = admin_email
        admin.password = admin_password

        respond_to do |format|
          if admin.save
            format.html { redirect_to panel_admins_path, notice: "Administrador actualizado correctamente." }
          else
            format.html { redirect_to panel_admins_path, error: "No se pudo actualizar los datos del Administrador." }
          end
        end

      else
        admin.email = admin_email

        respond_to do |format|
          if admin.save
            format.html { redirect_to panel_admins_path, notice: "Administrador actualizado correctamente." }
          else
            format.html { redirect_to panel_admins_path, error: "No se pudo actualizar los datos del Administrador." }
          end
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to panel_admins_path, notice: "No se pudo encontrar el usuario solicitado." }
      end
    end
    
  end


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password])
  end

  def after_sign_up_path_for(resource)
    panel_admins_path
  end

  def after_update_path_for(resource)
    panel_admins_path
  end

  #Update attributes without current password, but let user change their password.
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      super
    end
  end

end
