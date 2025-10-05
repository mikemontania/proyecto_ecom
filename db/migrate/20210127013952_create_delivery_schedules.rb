class CreateDeliverySchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_schedules do |t|
      t.string :title
      t.string :week_start_hour
      t.string :week_end_hour
      t.string :weekend_start_hour
      t.string :weekend_end_hour
      t.text :holydays #Separate by comma

      t.timestamps
    end
  end
end
