class AddMeasurementUnitToInternalProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :internal_products, :measurement_unit_code, :string
    add_foreign_key :internal_products, :measurement_units, column: :measurement_unit_code, primary_key: 'code'
  end
end
