class Panel::SettingsController < Panel::PanelController
  def index
    @settings = Setting.all.first_or_create do |settings|
      settings.minimum_purchase = 20_000
      settings.send_orders_to_service = true
      settings.multilanguage = false
    end
  end

  def update
    respond_to do |format|
      @settings = Setting.all.first
      if @settings.update(settings_params)
        format.html { redirect_to panel_settings_path, notice: 'Configuración actualizada.' }
        format.json { render :index, status: :ok, location: @settings }
      else
        format.html { render :index }
        format.json { render json: @settings.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def settings_params
    params.require(:setting).permit(:minimum_purchase, :send_orders_to_service, :contact_email, :multilanguage)
  end
end
