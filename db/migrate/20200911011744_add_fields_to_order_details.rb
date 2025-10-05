class AddFieldsToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_details, :internal_product, null: false, foreign_key: true
    add_column :order_details, :quantity, :decimal
    add_column :order_details, :unit_price, :decimal
    add_column :order_details, :gross_total, :decimal
    add_column :order_details, :discount_rate, :decimal
    add_column :order_details, :discount_amount, :decimal
    add_column :order_details, :net_total, :decimal
  end
end
