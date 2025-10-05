class AddTotalFieldsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :gross_total, :decimal
    add_column :orders, :discount_rate, :decimal
    add_column :orders, :discount_total, :decimal
    add_column :orders, :net_total, :decimal
    add_reference :orders, :branch, null: false, foreign_key: true
  end
end
