module Panel::DeliverySchedulesHelper

  def get_time(time)
    if time.empty? || time == "" || time.nil?
      return "00:00"
    else
      return Time.parse(time).strftime("%H:%M")
    end
  end
end
