class Panel::CountdownsController < Panel::PanelController
  before_action :set_countdown, only: %i[edit update]

  def edit
  end

  def update
    respond_to do |format|
      if @countdown.present?
        if @countdown.update(countdown_params)
          format.html { redirect_to panel_countdown_edit_path, notice: 'Contador actualizado.' }
        else
          format.html { render :edit }
        end
      else
        if @countdown.create(countdown_params)
          format.html { redirect_to panel_countdown_edit_path, notice: 'Contador actualizado.' }
        else
          format.html { render :edit }
        end

      end
    end
  end

  private

  def set_countdown
    @countdown = Countdown.where(id: 1).first
    if @countdown.nil?
      @countdown = Countdown.new
    else
      @countdown.start_date = @countdown.start_date.strftime("%d/%m/%Y")
      @countdown.end_date = @countdown.end_date.strftime("%d/%m/%Y")
    end

  end

  def countdown_params
    params.require(:countdown).permit(
      :title, :description, :start_date, :end_date, :link, :image_desktop, :image_mobile, :active)
  end
end
