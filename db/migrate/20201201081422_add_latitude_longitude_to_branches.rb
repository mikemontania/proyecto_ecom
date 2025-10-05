class AddLatitudeLongitudeToBranches < ActiveRecord::Migration[6.0]
  def change
    add_column :branches, :latitude, :decimal, precision: 12, scale: 8
    add_column :branches, :longitude, :decimal, precision: 12, scale: 8
  end
end
