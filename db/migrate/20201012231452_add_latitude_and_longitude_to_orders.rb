class AddLatitudeAndLongitudeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :latitude, :decimal, precision: 12, scale: 8
    add_column :orders, :longitude, :decimal, precision: 12, scale: 8
  end
end
