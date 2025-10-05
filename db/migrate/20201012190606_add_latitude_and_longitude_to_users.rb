class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :latitude, :decimal, precision: 12, scale: 8
    add_column :users, :longitude, :decimal, precision: 12, scale: 8
  end
end
