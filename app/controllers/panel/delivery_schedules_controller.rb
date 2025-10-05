class Panel::DeliverySchedulesController < Panel::PanelController
  before_action :set_delivery_schedule, only: %i[edit update]

  def edit; end

  def update
    respond_to do |format|
      if @delivery_schedule.update(delivery_schedule_params)
        format.html { redirect_to panel_delivery_schedules_path, notice: 'Horario de Delivery actualizado.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_delivery_schedule
    @delivery_schedule = DeliverySchedule.find(1)
  end

  def delivery_schedule_params
    params.require(:delivery_schedule).permit(
      :title, :week_start_hour, :week_end_hour, :weekend_start_hour, :weekend_end_hour, :holydays)
  end

end
