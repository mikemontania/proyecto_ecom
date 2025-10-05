class CreateMeasurementUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :measurement_units, id: false, primary_key: :code do |t|
      t.string :code, null: false, primary_key: true
      t.string :name
      t.timestamps
    end
  end
end
